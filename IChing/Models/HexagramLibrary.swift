import Foundation

/// The complete library of all 64 I Ching hexagrams
final class HexagramLibrary {
    static let shared = HexagramLibrary()
    
    private(set) var hexagrams: [Hexagram] = []
    private var lineToHexagramMap: [String: Int] = [:]
    
    private init() {
        loadHexagrams()
        buildLineMap()
    }
    
    /// Get hexagram by King Wen sequence number (1-64)
    func hexagram(number: Int) -> Hexagram? {
        guard number >= 1 && number <= 64 else { return nil }
        return hexagrams.first { $0.id == number }
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
