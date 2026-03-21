import Foundation
import SwiftData

/// A journal reflection on a reading
@Model
final class JournalEntry {
    #if swift(>=6.0)
    #Index<JournalEntry>([\.createdAt])
    #endif

    var id: UUID
    var createdAt: Date
    var updatedAt: Date
    var content: String
    var mood: Mood?
    
    // Relationship back to the reading
    var reading: Reading?
    
    init(content: String, mood: Mood? = nil, reading: Reading? = nil) {
        self.id = UUID()
        self.createdAt = Date()
        self.updatedAt = Date()
        self.content = content
        self.mood = mood
        self.reading = reading
    }
    
    /// Updates the entry content and timestamp
    func update(content: String, mood: Mood?) {
        self.content = content
        self.mood = mood
        self.updatedAt = Date()
    }
    
    var formattedDate: String {
        DateFormatters.mediumDateTime.string(from: createdAt)
    }
    
    private static let editThresholdSeconds: TimeInterval = 60

    var isEdited: Bool {
        updatedAt.timeIntervalSince(createdAt) > Self.editThresholdSeconds
    }
}

/// Mood associated with a journal entry
enum Mood: String, Codable, CaseIterable, Identifiable {
    case peaceful = "peaceful"
    case hopeful = "hopeful"
    case curious = "curious"
    case uncertain = "uncertain"
    case anxious = "anxious"
    case grateful = "grateful"
    case inspired = "inspired"
    case reflective = "reflective"
    
    var id: String { rawValue }
    
    var displayName: String {
        rawValue.capitalized
    }
    
    var emoji: String {
        switch self {
        case .peaceful: return "🧘"
        case .hopeful: return "🌅"
        case .curious: return "🔍"
        case .uncertain: return "🤔"
        case .anxious: return "😰"
        case .grateful: return "🙏"
        case .inspired: return "✨"
        case .reflective: return "🪷"
        }
    }
}
