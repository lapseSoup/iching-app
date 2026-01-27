import Foundation

/// Represents one of the 64 hexagrams of the I Ching
struct Hexagram: Identifiable, Codable, Equatable {
    let id: Int // 1-64, King Wen sequence
    let chineseName: String
    let pinyin: String
    let englishName: String
    let character: String // The hexagram character (e.g., ䷀)
    
    // The two trigrams
    let upperTrigram: Trigram
    let lowerTrigram: Trigram
    
    // Core texts
    let judgment: String      // The Judgment (卦辭) - King Wen
    let image: String         // The Image (象辭) - Duke of Zhou
    let commentary: String    // Overall interpretation
    
    // Line meanings (indices 0-5 = lines 1-6, bottom to top)
    let lineTexts: [LineMeaning]
    
    /// All six lines from bottom to top (derived from trigrams)
    var lines: [Bool] {
        lowerTrigram.lines + upperTrigram.lines
    }
    
    /// Unicode hexagram symbol
    var symbol: String {
        // Unicode hexagram symbols start at U+4DC0
        let baseCodePoint = 0x4DC0
        // King Wen sequence to binary conversion - we use stored character instead
        return character
    }
    
    /// Creates the related/transformed hexagram by flipping changing lines
    func transformed(withChangingLines changingPositions: Set<Int>) -> Hexagram? {
        guard !changingPositions.isEmpty else { return nil }
        
        var newLines = lines
        for position in changingPositions {
            guard position >= 1 && position <= 6 else { continue }
            newLines[position - 1].toggle()
        }
        
        // Find the hexagram with matching lines
        return HexagramLibrary.shared.hexagram(forLines: newLines)
    }
    
    static func == (lhs: Hexagram, rhs: Hexagram) -> Bool {
        lhs.id == rhs.id
    }
}

/// Meaning/interpretation for a single line
struct LineMeaning: Codable, Identifiable {
    var id: Int { position }
    let position: Int // 1-6
    let text: String
    let interpretation: String
}

/// Extension for convenience initializers
extension Hexagram {
    /// Creates hexagram from six line values
    static func from(lineValues: [LineValue]) -> (primary: Hexagram, relating: Hexagram?)? {
        guard lineValues.count == 6 else { return nil }
        
        let lines = lineValues.map { $0.isYang }
        guard let primary = HexagramLibrary.shared.hexagram(forLines: lines) else { return nil }
        
        let changingPositions = Set(lineValues.enumerated()
            .filter { $0.element.isChanging }
            .map { $0.offset + 1 })
        
        let relating = primary.transformed(withChangingLines: changingPositions)
        
        return (primary, relating)
    }
}
