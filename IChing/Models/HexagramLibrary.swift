import Foundation
import os

/// Protocol for hexagram data access — enables dependency injection and testing
protocol HexagramRepository {
    func hexagram(number: Int) -> Hexagram?
    func hexagram(forLines lines: [Bool]) -> Hexagram?
    var hexagrams: [Hexagram] { get }
}

// MARK: - JSON Decoding Types

/// Codable representation of a hexagram for JSON loading
private struct CodableHexagram: Codable {
    let id: Int
    let chineseName: String
    let pinyin: String
    let englishName: String
    let character: String
    let upperTrigram: String
    let lowerTrigram: String
    let judgment: String
    let image: String
    let commentary: String
    let lineTexts: [CodableLineMeaning]

    func toHexagram() -> Hexagram? {
        guard let upper = Trigram.from(name: upperTrigram),
              let lower = Trigram.from(name: lowerTrigram) else { return nil }
        return Hexagram(
            id: id,
            chineseName: chineseName,
            pinyin: pinyin,
            englishName: englishName,
            character: character,
            upperTrigram: upper,
            lowerTrigram: lower,
            judgment: judgment,
            image: image,
            commentary: commentary,
            lineTexts: lineTexts.map { $0.toLineMeaning() }
        )
    }
}

private struct CodableLineMeaning: Codable {
    let position: Int
    let text: String
    let interpretation: String

    func toLineMeaning() -> LineMeaning {
        LineMeaning(position: position, text: text, interpretation: interpretation)
    }
}

/// The complete library of all 64 I Ching hexagrams
final class HexagramLibrary: HexagramRepository {
    static let shared: HexagramRepository = HexagramLibrary()

    private(set) var hexagrams: [Hexagram] = []
    private var lineToHexagramMap: [String: Int] = [:]

    private init() {
        guard loadFromJSON() else {
            AppLogger.persistence.fault("hexagrams.json missing or invalid in app bundle — broken build configuration")
            fatalError("hexagrams.json missing from app bundle — this indicates a broken build configuration")
        }
        buildLineMap()
    }

    /// Loads hexagram data from the bundled hexagrams.json file.
    /// Returns true if loading succeeded, false to fall back to hardcoded data.
    private func loadFromJSON() -> Bool {
        guard let url = Bundle.main.url(forResource: "hexagrams", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let codable = try? JSONDecoder().decode([CodableHexagram].self, from: data) else {
            return false
        }
        let loaded = codable.compactMap { $0.toHexagram() }
        guard loaded.count == 64 else { return false }
        hexagrams = loaded.sorted { $0.id < $1.id }
        return true
    }
    
    /// Get hexagram by King Wen sequence number (1-64)
    func hexagram(number: Int) -> Hexagram? {
        guard number >= 1 && number <= 64 && number <= hexagrams.count else { return nil }
        let hex = hexagrams[number - 1]
        guard hex.id == number else {
            // Fallback to linear search if array is not sorted by id
            return hexagrams.first { $0.id == number }
        }
        return hex
    }
    
    /// Get hexagram by matching six lines (bottom to top)
    func hexagram(forLines lines: [Bool]) -> Hexagram? {
        guard lines.count == 6 else { return nil }
        let key = lines.map { $0 ? "1" : "0" }.joined()
        guard let id = lineToHexagramMap[key] else { return nil }
        return hexagram(number: id)
    }
    
    private func buildLineMap() {
        for hex in hexagrams {
            let key = hex.lines.map { $0 ? "1" : "0" }.joined()
            lineToHexagramMap[key] = hex.id
        }
    }
}
