import Foundation
import SwiftData
import os.log

/// A single I Ching reading session
@Model
final class Reading {
    /// Number of lines in a hexagram — the I Ching invariant.
    static let lineCount = 6

    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.iching.app", category: "Reading")
    #if swift(>=6.0)
    #Index<Reading>([\.createdAt])
    #endif

    var id: UUID
    var createdAt: Date
    var question: String
    var notes: String

    // Line values stored as array of raw integers (6, 7, 8, or 9), bottom to top
    var lineValuesRaw: [Int]

    // Hexagram IDs for quick reference
    var primaryHexagramId: Int
    var relatingHexagramId: Int? // nil if no changing lines

    // Journal entries for this reading
    @Relationship(deleteRule: .cascade, inverse: \JournalEntry.reading)
    var journalEntries: [JournalEntry]

    // Method of divination
    var method: ReadingMethod

    // Whether this is the daily hexagram
    var isDailyReading: Bool

    // Cached hexagram lookups (transient — not persisted)
    @Transient private var _cachedPrimary: Hexagram?
    @Transient private var _cachedRelating: Hexagram?
    @Transient private var _hexagramsCached = false
    @Transient private var _repository: HexagramRepository?

    // Cached line computations (transient — not persisted)
    @Transient private var _cachedLines: [Line]?
    @Transient private var _cachedChangingPositions: Set<Int>?

    /// True if stored line data is malformed (wrong count or invalid raw values).
    /// Computed on demand — no hidden mutation in getters.
    @Transient var hasCorruptedData: Bool {
        guard lineValuesRaw.count == Self.lineCount else { return true }
        return lineValuesRaw.contains { LineValue(rawValue: $0) == nil }
    }

    /// Public convenience initializer — resolves the hexagram IDs internally.
    /// Use `Reading.create(...)` to surface resolution failures via `Result`.
    convenience init(
        question: String = "",
        lines: [LineValue],
        method: ReadingMethod = .coinFlip,
        isDailyReading: Bool = false
    ) {
        let result = Hexagram.from(lineValues: lines)
        if result == nil {
            // This should never happen with valid LineValue inputs — log for debugging
            Self.logger.warning("Could not resolve hexagram from lines \(lines.map(\.rawValue), privacy: .private), defaulting to hexagram 1")
        }
        self.init(
            question: question,
            lines: lines,
            method: method,
            isDailyReading: isDailyReading,
            primaryHexagramId: result?.primary.id ?? 1,
            relatingHexagramId: result?.relating?.id
        )
    }

    /// Designated initializer used by `create(...)` to avoid double-resolving
    /// the hexagram. B-59: callers who already know the IDs (because they
    /// resolved once for validation) pass them in here so `init` doesn't re-run
    /// `Hexagram.from` a second time.
    init(
        question: String,
        lines: [LineValue],
        method: ReadingMethod,
        isDailyReading: Bool,
        primaryHexagramId: Int,
        relatingHexagramId: Int?
    ) {
        precondition(lines.count == Self.lineCount, "Reading requires exactly \(Self.lineCount) lines")
        self.id = UUID()
        self.createdAt = Date()
        self.question = question
        self.notes = ""
        self.method = method
        self.isDailyReading = isDailyReading
        self.journalEntries = []
        self.lineValuesRaw = lines.map(\.rawValue)
        self.primaryHexagramId = primaryHexagramId
        self.relatingHexagramId = relatingHexagramId
    }

    /// Failable initializer that returns an error instead of silently defaulting.
    /// B-59: resolves the hexagram exactly once and threads the IDs through to `init`.
    static func create(
        question: String = "",
        lines: [LineValue],
        method: ReadingMethod = .coinFlip,
        isDailyReading: Bool = false
    ) -> Result<Reading, IChingError> {
        guard lines.count == lineCount else {
            return .failure(.invalidLineCount(expected: lineCount, actual: lines.count))
        }
        guard let result = Hexagram.from(lineValues: lines) else {
            return .failure(.hexagramResolutionFailed(lineValues: lines.map(\.rawValue)))
        }
        return .success(Reading(
            question: question,
            lines: lines,
            method: method,
            isDailyReading: isDailyReading,
            primaryHexagramId: result.primary.id,
            relatingHexagramId: result.relating?.id
        ))
    }

    /// Reconstructs line values from stored data. Invalid raw values fall back to youngYang
    /// (also surfaced via `hasCorruptedData`).
    var lineValues: [LineValue] {
        return lineValuesRaw.enumerated().map { index, rawVal in
            guard let value = LineValue(rawValue: rawVal) else {
                Self.logger.warning("Invalid line value \(rawVal, privacy: .private) at position \(index + 1), defaulting to youngYang")
                return .youngYang
            }
            return value
        }
    }

    /// Lines as Line objects (cached; validated for count)
    var lines: [Line] {
        if let cached = _cachedLines { return cached }
        guard lineValuesRaw.count == Self.lineCount else {
            Self.logger.error("Expected \(Self.lineCount) line values, got \(self.lineValuesRaw.count). Returning default lines.")
            let fallback = (1...Self.lineCount).map { Line(position: $0, value: .youngYang) }
            _cachedLines = fallback
            return fallback
        }
        let result = lineValues.enumerated().map { index, value in
            Line(position: index + 1, value: value)
        }
        _cachedLines = result
        return result
    }

    /// Positions of changing lines (1-6, cached)
    var changingLinePositions: Set<Int> {
        if let cached = _cachedChangingPositions { return cached }
        guard lineValuesRaw.count == Self.lineCount else {
            Self.logger.error("Expected \(Self.lineCount) line values, got \(self.lineValuesRaw.count). Returning empty changing positions.")
            _cachedChangingPositions = []
            return []
        }
        let result = Set(lines.filter { $0.isChanging }.map { $0.position })
        _cachedChangingPositions = result
        return result
    }

    /// Whether this reading has any changing lines
    var hasChangingLines: Bool {
        !changingLinePositions.isEmpty
    }

    /// The primary hexagram (cached after first access)
    var primaryHexagram: Hexagram? {
        ensureHexagramCache()
        return _cachedPrimary
    }

    /// The relating/transformed hexagram (cached after first access)
    var relatingHexagram: Hexagram? {
        ensureHexagramCache()
        return _cachedRelating
    }

    /// Populates transient hexagram cache on first access. Safe to call from
    /// computed properties because Reading is a reference type (@Model class)
    /// and @Transient properties are not observed by SwiftData.
    ///
    /// A-44: Resolution order is (1) per-instance `_repository` set via
    /// `withRepository(_:)` for tightly-scoped test cases, then (2) the process-wide
    /// `Hexagrams.current`. Tests that want to redirect every Reading at once should
    /// reassign `Hexagrams.current` in setUp; tests that need per-instance isolation
    /// use `.withRepository(_:)`.
    private func ensureHexagramCache() {
        guard !_hexagramsCached else { return }
        let repository = _repository ?? Hexagrams.current
        _cachedPrimary = repository.hexagram(number: primaryHexagramId)
        if let relId = relatingHexagramId {
            _cachedRelating = repository.hexagram(number: relId)
        }
        _hexagramsCached = true
    }

    /// Invalidates transient line caches. Call when `lineValuesRaw` is modified externally.
    func invalidateLineCaches() {
        _cachedLines = nil
        _cachedChangingPositions = nil
    }

    /// Injects a custom repository for testing. Returns self for chaining.
    @discardableResult
    func withRepository(_ repository: HexagramRepository) -> Reading {
        _repository = repository
        _hexagramsCached = false
        return self
    }

}

// MARK: - Formatting

extension Reading {
    /// Formatted date for display
    var formattedDate: String {
        DateFormatters.longDate.string(from: createdAt)
    }

    /// Short date for lists
    var shortDate: String {
        DateFormatters.shortDate.string(from: createdAt)
    }
}

/// Method used to generate the reading
enum ReadingMethod: String, Codable, CaseIterable {
    case coinFlip = "coin"
    case manual = "manual"
    case yarrowStalks = "yarrow"
    case random = "random" // For daily hexagram
    
    var displayName: String {
        switch self {
        case .coinFlip: return "Three-Coin Method"
        case .manual: return "Manual Entry"
        case .yarrowStalks: return "Yarrow Stalk Method"
        case .random: return "Random"
        }
    }
    
    var icon: String {
        switch self {
        case .coinFlip: return "circle.circle"
        case .manual: return "hand.tap"
        case .yarrowStalks: return "leaf"
        case .random: return "sparkles"
        }
    }
}
