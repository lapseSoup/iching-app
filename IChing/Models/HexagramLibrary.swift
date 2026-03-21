import Foundation

/// Protocol for hexagram data access — enables dependency injection and testing
protocol HexagramRepository {
    func hexagram(number: Int) -> Hexagram?
    func hexagram(forLines lines: [Bool]) -> Hexagram?
    func hexagram(upper: Trigram, lower: Trigram) -> Hexagram?
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
        if !loadFromJSON() {
            loadHexagrams() // Fallback to hardcoded data
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
    
    /// Get hexagram by upper and lower trigrams
    func hexagram(upper: Trigram, lower: Trigram) -> Hexagram? {
        let lines = lower.lines + upper.lines
        return hexagram(forLines: lines)
    }
    
    private func buildLineMap() {
        for hex in hexagrams {
            let key = hex.lines.map { $0 ? "1" : "0" }.joined()
            lineToHexagramMap[key] = hex.id
        }
    }
    
    private func loadHexagrams() {
        hexagrams = [
            createHexagram1(),
            createHexagram2(),
            createHexagram3(),
            createHexagram4(),
            createHexagram5(),
            createHexagram6(),
            createHexagram7(),
            createHexagram8(),
            createHexagram9(),
            createHexagram10(),
            createHexagram11(),
            createHexagram12(),
            createHexagram13(),
            createHexagram14(),
            createHexagram15(),
            createHexagram16(),
            createHexagram17(),
            createHexagram18(),
            createHexagram19(),
            createHexagram20(),
            createHexagram21(),
            createHexagram22(),
            createHexagram23(),
            createHexagram24(),
            createHexagram25(),
            createHexagram26(),
            createHexagram27(),
            createHexagram28(),
            createHexagram29(),
            createHexagram30(),
            createHexagram31(),
            createHexagram32(),
            createHexagram33(),
            createHexagram34(),
            createHexagram35(),
            createHexagram36(),
            createHexagram37(),
            createHexagram38(),
            createHexagram39(),
            createHexagram40(),
            createHexagram41(),
            createHexagram42(),
            createHexagram43(),
            createHexagram44(),
            createHexagram45(),
            createHexagram46(),
            createHexagram47(),
            createHexagram48(),
            createHexagram49(),
            createHexagram50(),
            createHexagram51(),
            createHexagram52(),
            createHexagram53(),
            createHexagram54(),
            createHexagram55(),
            createHexagram56(),
            createHexagram57(),
            createHexagram58(),
            createHexagram59(),
            createHexagram60(),
            createHexagram61(),
            createHexagram62(),
            createHexagram63(),
            createHexagram64()
        ]
    }
}
