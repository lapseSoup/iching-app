import Foundation
import SwiftData

/// Appearance preference for the app
enum AppColorScheme: String, Codable, CaseIterable {
    case system
    case light
    case dark

    var displayName: String {
        rawValue.capitalized
    }
}

/// User preferences and settings
@Model
final class AppSettings {
    @Attribute(.unique) var id: UUID

    // Daily hexagram settings
    var dailyHexagramEnabled: Bool
    var dailyNotificationTime: Date
    var lastDailyHexagramDate: Date?

    // Display preferences
    var showChineseCharacters: Bool
    var showPinyin: Bool
    var preferredLanguage: String // "en", "zh"

    // Reading preferences
    var defaultReadingMethod: ReadingMethod
    var hapticFeedbackEnabled: Bool
    var soundEffectsEnabled: Bool

    // Appearance
    var colorScheme: AppColorScheme

    // Privacy
    var iCloudSyncEnabled: Bool

    static let singletonID = UUID(uuidString: "00000000-0000-0000-0000-000000000001")!

    init() {
        self.id = Self.singletonID
        self.dailyHexagramEnabled = false

        // Default notification time: 8:00 AM
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        self.dailyNotificationTime = Calendar.current.date(from: components) ?? Date()

        self.showChineseCharacters = true
        self.showPinyin = true
        self.preferredLanguage = "en"
        self.defaultReadingMethod = .coinFlip
        self.hapticFeedbackEnabled = true
        self.soundEffectsEnabled = true
        self.colorScheme = .system
        self.iCloudSyncEnabled = false
    }
}
