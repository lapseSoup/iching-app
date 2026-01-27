import Foundation
import SwiftData

/// User preferences and settings
@Model
final class AppSettings {
    var id: UUID
    
    // Daily hexagram settings
    var dailyHexagramEnabled: Bool
    var dailyNotificationTime: Date
    var lastDailyHexagramDate: Date?
    
    // Display preferences
    var showChineseCharacters: Bool
    var showPinyin: Bool
    var preferredLanguage: String // "en", "zh"
    
    // Reading preferences
    var defaultReadingMethod: String
    var hapticFeedbackEnabled: Bool
    var soundEffectsEnabled: Bool
    
    // Appearance
    var colorScheme: String // "system", "light", "dark"
    
    init() {
        self.id = UUID()
        self.dailyHexagramEnabled = false
        
        // Default notification time: 8:00 AM
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        self.dailyNotificationTime = Calendar.current.date(from: components) ?? Date()
        
        self.showChineseCharacters = true
        self.showPinyin = true
        self.preferredLanguage = "en"
        self.defaultReadingMethod = ReadingMethod.coinFlip.rawValue
        self.hapticFeedbackEnabled = true
        self.soundEffectsEnabled = true
        self.colorScheme = "system"
    }
    
    var readingMethod: ReadingMethod {
        get { ReadingMethod(rawValue: defaultReadingMethod) ?? .coinFlip }
        set { defaultReadingMethod = newValue.rawValue }
    }
}
