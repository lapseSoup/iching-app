import Foundation

/// Minimal hexagram data shared between the main app and widget extension.
/// Add this file to BOTH the IChing and IChingWidgets targets in Xcode.
struct HexagramBasicInfo: Codable, Identifiable {
    let id: Int
    let englishName: String
    let chineseName: String
    let character: String
    let lines: [Bool] // true = yang (solid), bottom to top

    /// All 64 hexagrams — loaded from hexagram_basic.json (single source of truth).
    /// Both the main app and widget extension share this JSON file, eliminating
    /// the previous dual-source problem where hardcoded structs could drift from hexagrams.json.
    ///
    /// S-24/Q-65: This is a `fatalError` rather than `assertionFailure` because every
    /// call site downstream (widget views, snapshots, timeline entries) subscripts the
    /// returned array directly. A debug-only assert with `return []` would crash silently
    /// in release on the next subscript anyway — better to fail fast and loud.
    static let all: [HexagramBasicInfo] = {
        guard let url = Bundle.main.url(forResource: "hexagram_basic", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([HexagramBasicInfo].self, from: data),
              decoded.count == 64 else {
            fatalError("hexagram_basic.json missing or corrupt in app bundle — broken build configuration")
        }
        return decoded.sorted { $0.id < $1.id }
    }()

    /// Deterministic daily hexagram ID based on date.
    /// Shared algorithm — used by both widget and notification service.
    static func dailyHexagramId(for date: Date) -> Int {
        let calendar = Calendar.current
        let day = calendar.ordinality(of: .day, in: .era, for: date) ?? 1
        // Use multiplicative hash for less predictable daily sequence
        var h = day &* 2654435761
        h = (h >> 16) ^ h
        return ((h % 64) + 64) % 64 + 1
    }
}
