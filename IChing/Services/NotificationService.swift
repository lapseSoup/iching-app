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

    /// Schedules daily hexagram notifications for the next 7 days.
    /// Each day gets its own notification with the correct hexagram for that date.
    /// Call this on app launch and whenever the notification time changes.
    func scheduleDailyHexagram(at time: Date) async {
        if !isAuthorized {
            let granted = await requestAuthorization()
            guard granted else { return }
        }

        // Cancel existing daily notifications
        cancelDailyNotifications()

        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)

        // Schedule one notification per day for the next 7 days,
        // each with the correct hexagram for that specific date.
        for dayOffset in 0..<7 {
            guard let targetDate = calendar.date(byAdding: .day, value: dayOffset, to: Date()) else { continue }

            let hexagramId = HexagramBasicInfo.dailyHexagramId(for: targetDate)
            guard let hexagram = HexagramLibrary.shared.hexagram(number: hexagramId) else { continue }

            let content = UNMutableNotificationContent()
            content.title = "Daily Hexagram"
            content.subtitle = "\(hexagram.id). \(hexagram.englishName)"
            content.body = "\(hexagram.chineseName) (\(hexagram.pinyin)) - Tap to explore today's wisdom."
            content.sound = .default

            var dateComponents = calendar.dateComponents([.year, .month, .day], from: targetDate)
            dateComponents.hour = timeComponents.hour
            dateComponents.minute = timeComponents.minute
            dateComponents.second = 0

            let trigger = UNCalendarNotificationTrigger(
                dateMatching: dateComponents,
                repeats: false
            )

            let request = UNNotificationRequest(
                identifier: "\(Self.dailyHexagramIdentifier)-\(dayOffset)",
                content: content,
                trigger: trigger
            )

            do {
                try await UNUserNotificationCenter.current().add(request)
            } catch {
                Self.logger.error("Failed to schedule daily hexagram for day \(dayOffset): \(error.localizedDescription, privacy: .public)")
            }
        }
    }

    func cancelDailyNotifications() {
        let identifiers = (0..<7).map { "\(Self.dailyHexagramIdentifier)-\($0)" }
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: identifiers
        )
    }
}
