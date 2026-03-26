import Foundation
import SwiftData
import os.log

/// A single I Ching reading session
@Model
final class Reading {
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

    /// Indicates that stored line data was corrupted and fallback values were used.
    @Transient var hasCorruptedData: Bool = false

    init(
        question: String = "",
        lines: [LineValue],
        method: ReadingMethod = .coinFlip,
        isDailyReading: Bool = false
    ) {
        precondition(lines.count == 6, "Reading requires exactly 6 lines")
        self.id = UUID()
        self.createdAt = Date()
        self.question = question
        self.notes = ""
        self.method = method
        self.isDailyReading = isDailyReading
        self.journalEntries = []

        // Store as normalized array
        self.lineValuesRaw = lines.map(\.rawValue)

        // Calculate hexagram IDs
        if let result = Hexagram.from(lineValues: lines) {
            self.primaryHexagramId = result.primary.id
            self.relatingHexagramId = result.relating?.id
        } else {
            // This should never happen with valid LineValue inputs — log for debugging
            Self.logger.warning("Could not resolve hexagram from lines \(lines.map(\.rawValue), privacy: .private), defaulting to hexagram 1")
            self.primaryHexagramId = 1
            self.relatingHexagramId = nil
        }
    }

    /// Failable initializer that returns an error instead of silently defaulting
    static func create(
        question: String = "",
        lines: [LineValue],
        method: ReadingMethod = .coinFlip,
        isDailyReading: Bool = false
    ) -> Result<Reading, IChingError> {
        guard lines.count == 6 else {
            return .failure(.invalidLineCount(expected: 6, actual: lines.count))
        }
        guard Hexagram.from(lineValues: lines) != nil else {
            return .failure(.hexagramResolutionFailed(lineValues: lines.map(\.rawValue)))
        }
        return .success(Reading(question: question, lines: lines, method: method, isDailyReading: isDailyReading))
    }

    /// Reconstructs line values from stored data
    var lineValues: [LineValue] {
        return lineValuesRaw.enumerated().map { index, rawVal in
            guard let value = LineValue(rawValue: rawVal) else {
                Self.logger.warning("Invalid line value \(rawVal, privacy: .private) at position \(index + 1), defaulting to youngYang")
                hasCorruptedData = true
                return .youngYang
            }
            return value
        }
    }

    /// Lines as Line objects (cached; validated for count)
    var lines: [Line] {
        if let cached = _cachedLines { return cached }
        guard lineValuesRaw.count == 6 else {
            Self.logger.error("Expected 6 line values, got \(self.lineValuesRaw.count). Returning default lines.")
            hasCorruptedData = true
            let fallback = (1...6).map { Line(position: $0, value: .youngYang) }
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
        guard lineValuesRaw.count == 6 else {
            Self.logger.error("Expected 6 line values, got \(self.lineValuesRaw.count). Returning empty changing positions.")
            hasCorruptedData = true
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
    private func ensureHexagramCache() {
        guard !_hexagramsCached else { return }
        let repository = _repository ?? HexagramLibrary.shared
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
