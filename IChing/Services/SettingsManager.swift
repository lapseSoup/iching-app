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
        do {
            if let existing = try modelContext.fetch(descriptor).first {
                self.settings = existing
                return
            }
        } catch {
            AppLogger.persistence.error("SettingsManager: failed to fetch AppSettings — \(error.localizedDescription, privacy: .private)")
        }

        let newSettings = AppSettings()
        modelContext.insert(newSettings)
        do {
            try modelContext.save()
        } catch {
            AppLogger.persistence.error("SettingsManager: failed to save initial AppSettings — \(error.localizedDescription, privacy: .private)")
        }
        self.settings = newSettings
    }

    /// Saves any pending mutations to the AppSettings model. Failures are logged
    /// rather than surfaced — settings writes are background concerns from the user's
    /// perspective, and SwiftData's auto-save provides a last-resort safety net.
    private func persist() {
        do {
            try modelContext.save()
        } catch {
            AppLogger.persistence.error("SettingsManager: persist failed — \(error.localizedDescription, privacy: .private)")
        }
    }

    // MARK: - Display Preferences

    var showChineseCharacters: Bool {
        get { settings.showChineseCharacters }
        set {
            settings.showChineseCharacters = newValue
            persist()
        }
    }

    var showPinyin: Bool {
        get { settings.showPinyin }
        set {
            settings.showPinyin = newValue
            persist()
        }
    }

    var appColorScheme: AppColorScheme {
        get { settings.colorScheme }
        set {
            settings.colorScheme = newValue
            persist()
        }
    }

    var preferredColorScheme: ColorScheme? {
        switch settings.colorScheme {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }

    // MARK: - Daily Hexagram

    var dailyHexagramEnabled: Bool {
        get { settings.dailyHexagramEnabled }
        set {
            settings.dailyHexagramEnabled = newValue
            persist()
        }
    }

    var dailyNotificationTime: Date {
        get { settings.dailyNotificationTime }
        set {
            settings.dailyNotificationTime = newValue
            persist()
        }
    }

    // MARK: - Feedback

    var hapticFeedbackEnabled: Bool {
        get { settings.hapticFeedbackEnabled }
        set {
            settings.hapticFeedbackEnabled = newValue
            HapticService.isEnabled = newValue
            persist()
        }
    }

    // MARK: - Privacy

    var iCloudSyncEnabled: Bool {
        get { settings.iCloudSyncEnabled }
        set {
            settings.iCloudSyncEnabled = newValue
            persist()
        }
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

// MARK: - Safe Read-Only View (Q-60 / Q-61)

/// A read-only snapshot of settings with canonical defaults baked in.
/// Use this in views that only need to *read* settings, so they never have to
/// reason about the optionality of `settingsManager` or duplicate defaults.
///
/// Construct via `EnvironmentValues.settings` — it captures a snapshot of the
/// injected SettingsManager values (if any) or AppSettings defaults otherwise.
/// Because it's a value snapshot, it's safe to read from any actor context.
struct SettingsView_ReadOnly: Sendable {
    let showChineseCharacters: Bool
    let showPinyin: Bool
    let hapticFeedbackEnabled: Bool
    let iCloudSyncEnabled: Bool
    let dailyHexagramEnabled: Bool
    let appColorScheme: AppColorScheme

    @MainActor
    init(_ manager: SettingsManager?) {
        if let m = manager {
            self.showChineseCharacters = m.settings.showChineseCharacters
            self.showPinyin = m.settings.showPinyin
            self.hapticFeedbackEnabled = m.settings.hapticFeedbackEnabled
            self.iCloudSyncEnabled = m.settings.iCloudSyncEnabled
            self.dailyHexagramEnabled = m.settings.dailyHexagramEnabled
            self.appColorScheme = m.settings.colorScheme
        } else {
            self.showChineseCharacters = true
            self.showPinyin = true
            self.hapticFeedbackEnabled = true
            self.iCloudSyncEnabled = false
            self.dailyHexagramEnabled = false
            self.appColorScheme = .system
        }
    }

    var preferredColorScheme: ColorScheme? {
        switch appColorScheme {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}

extension EnvironmentValues {
    /// Safe read-only access to settings. Returns canonical defaults when the
    /// SettingsManager hasn't been injected. Use this in views; only views that
    /// need to *write* settings should reach for `settingsManager` directly.
    /// `@MainActor` because SwiftUI environment access happens on the main actor.
    @MainActor
    var settings: SettingsView_ReadOnly {
        SettingsView_ReadOnly(self[SettingsManagerKey.self])
    }
}
