import Foundation
import SwiftData

/// A single I Ching reading session
@Model
final class Reading {
    var id: UUID
    var createdAt: Date
    var question: String
    var notes: String
    
    // Line values stored as raw integers (6, 7, 8, or 9)
    var lineValue1: Int
    var lineValue2: Int
    var lineValue3: Int
    var lineValue4: Int
    var lineValue5: Int
    var lineValue6: Int
    
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
    
    init(
        question: String = "",
        lines: [LineValue],
        method: ReadingMethod = .coinFlip,
        isDailyReading: Bool = false
    ) {
        self.id = UUID()
        self.createdAt = Date()
        self.question = question
        self.notes = ""
        self.method = method
        self.isDailyReading = isDailyReading
        self.journalEntries = []
        
        // Store line values
        self.lineValue1 = lines.indices.contains(0) ? lines[0].rawValue : 7
        self.lineValue2 = lines.indices.contains(1) ? lines[1].rawValue : 7
        self.lineValue3 = lines.indices.contains(2) ? lines[2].rawValue : 7
        self.lineValue4 = lines.indices.contains(3) ? lines[3].rawValue : 7
        self.lineValue5 = lines.indices.contains(4) ? lines[4].rawValue : 7
        self.lineValue6 = lines.indices.contains(5) ? lines[5].rawValue : 7
        
        // Calculate hexagram IDs
        let lineVals = self.lineValues
        if let result = Hexagram.from(lineValues: lineVals) {
            self.primaryHexagramId = result.primary.id
            self.relatingHexagramId = result.relating?.id
        } else {
            self.primaryHexagramId = 1
            self.relatingHexagramId = nil
        }
    }
    
    /// Reconstructs line values from stored integers
    var lineValues: [LineValue] {
        [lineValue1, lineValue2, lineValue3, lineValue4, lineValue5, lineValue6]
            .map { LineValue(rawValue: $0) ?? .youngYang }
    }
    
    /// Lines as Line objects
    var lines: [Line] {
        lineValues.enumerated().map { index, value in
            Line(position: index + 1, value: value)
        }
    }
    
    /// Positions of changing lines (1-6)
    var changingLinePositions: Set<Int> {
        Set(lines.filter { $0.isChanging }.map { $0.position })
    }
    
    /// Whether this reading has any changing lines
    var hasChangingLines: Bool {
        !changingLinePositions.isEmpty
    }
    
    /// The primary hexagram
    var primaryHexagram: Hexagram? {
        HexagramLibrary.shared.hexagram(number: primaryHexagramId)
    }
    
    /// The relating/transformed hexagram (if changing lines exist)
    var relatingHexagram: Hexagram? {
        guard let id = relatingHexagramId else { return nil }
        return HexagramLibrary.shared.hexagram(number: id)
    }
    
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
