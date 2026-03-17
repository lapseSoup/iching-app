import Foundation
import UserNotifications
import SwiftUI
import os.log

/// Manages local notification scheduling for daily hexagrams.
/// Uses @MainActor to ensure isAuthorized is always mutated on the main thread,
/// avoiding the re-render risk of @Observable on a non-isolated singleton.
@MainActor @Observable
final class NotificationService {
    static let shared = NotificationService()

    private static let dailyHexagramIdentifier = "daily-hexagram"
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.iching.app", category: "Notifications")

    private init() {}

    var isAuthorized: Bool = false

    func requestAuthorization() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .badge, .sound]
            )
            isAuthorized = granted
            return granted
        } catch {
            Self.logger.error("Notification authorization error: \(error.localizedDescription, privacy: .public)")
            return false
        }
    }

    func checkAuthorizationStatus() async {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        isAuthorized = settings.authorizationStatus == .authorized
    }

    func scheduleDailyHexagram(at time: Date) async {
        guard isAuthorized else {
            let granted = await requestAuthorization()
            guard granted else { return }
        }

        // Cancel existing daily notifications
        cancelDailyNotifications()

        // Use shared date-based seeding for consistent daily hexagram (matches widget)
        let hexagramId = HexagramBasicInfo.dailyHexagramId(for: Date())
        guard let hexagram = HexagramLibrary.shared.hexagram(number: hexagramId) else {
            return
        }

        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = "Daily Hexagram"
        content.subtitle = "\(hexagram.id). \(hexagram.englishName)"
        content.body = "\(hexagram.chineseName) (\(hexagram.pinyin)) - Tap to explore today's wisdom."
        content.sound = .default

        // Extract hour and minute from the time
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: time)

        var dateComponents = DateComponents()
        dateComponents.hour = components.hour
        dateComponents.minute = components.minute
        dateComponents.second = 0

        // Create trigger for daily repetition
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )

        // Create request
        let request = UNNotificationRequest(
            identifier: Self.dailyHexagramIdentifier,
            content: content,
            trigger: trigger
        )

        do {
            try await UNUserNotificationCenter.current().add(request)
        } catch {
            Self.logger.error("Failed to schedule daily hexagram: \(error.localizedDescription, privacy: .public)")
        }
    }

    func cancelDailyNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: [Self.dailyHexagramIdentifier]
        )
    }
}
