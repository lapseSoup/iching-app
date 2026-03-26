import Foundation
import SwiftData
import SwiftUI

/// Centralized settings manager that loads AppSettings once and provides
/// read/write access to all views via SwiftUI's environment.
/// Eliminates redundant @Query calls for AppSettings across the view hierarchy.
@MainActor
@Observable
final class SettingsManager {
    private let modelContext: ModelContext

    /// The single AppSettings row, loaded once and cached.
    private(set) var settings: AppSettings

    init(modelContext: ModelContext) {
        self.modelContext = modelContext

        // Fetch or create the singleton AppSettings row
        let descriptor = FetchDescriptor<AppSettings>()
        let existing = (try? modelContext.fetch(descriptor))?.first
        if let existing {
            self.settings = existing
        } else {
            let newSettings = AppSettings()
            modelContext.insert(newSettings)
            try? modelContext.save()
            self.settings = newSettings
        }
    }

    // MARK: - Display Preferences

    var showChineseCharacters: Bool {
        get { settings.showChineseCharacters }
        set { settings.showChineseCharacters = newValue }
    }

    var showPinyin: Bool {
        get { settings.showPinyin }
        set { settings.showPinyin = newValue }
    }

    var appColorScheme: AppColorScheme {
        get { settings.appColorScheme }
        set { settings.appColorScheme = newValue }
    }

    var preferredColorScheme: ColorScheme? {
        switch settings.appColorScheme {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }

    // MARK: - Daily Hexagram

    var dailyHexagramEnabled: Bool {
        get { settings.dailyHexagramEnabled }
        set { settings.dailyHexagramEnabled = newValue }
    }

    var dailyNotificationTime: Date {
        get { settings.dailyNotificationTime }
        set { settings.dailyNotificationTime = newValue }
    }

    // MARK: - Feedback

    var hapticFeedbackEnabled: Bool {
        get { settings.hapticFeedbackEnabled }
        set {
            settings.hapticFeedbackEnabled = newValue
            HapticService.isEnabled = newValue
        }
    }

    // MARK: - Privacy

    var iCloudSyncEnabled: Bool {
        get { settings.iCloudSyncEnabled }
        set { settings.iCloudSyncEnabled = newValue }
    }
}

// MARK: - Environment Key

struct SettingsManagerKey: EnvironmentKey {
    static let defaultValue: SettingsManager? = nil
}

extension EnvironmentValues {
    var settingsManager: SettingsManager? {
        get { self[SettingsManagerKey.self] }
        set { self[SettingsManagerKey.self] = newValue }
    }
}
