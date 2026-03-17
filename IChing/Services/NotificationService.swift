import Foundation
import UserNotifications
import SwiftUI

@Observable
final class NotificationService {
    static let shared = NotificationService()
    
    private init() {}
    
    var isAuthorized: Bool = false
    
    func requestAuthorization() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .badge, .sound]
            )
            await MainActor.run {
                isAuthorized = granted
            }
            return granted
        } catch {
            print("Notification authorization error: \(error)")
            return false
        }
    }
    
    func checkAuthorizationStatus() async {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        await MainActor.run {
            isAuthorized = settings.authorizationStatus == .authorized
        }
    }
    
    func scheduleDailyHexagram(at time: Date) async {
        guard isAuthorized else {
            let granted = await requestAuthorization()
            guard granted else { return }
        }
        
        // Cancel existing daily notifications
        cancelDailyNotifications()
        
        // Get a random hexagram
        guard let hexagram = HexagramLibrary.shared.hexagram(number: Int.random(in: 1...64)) else {
            return
        }
        
        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = "Daily Hexagram"
        content.subtitle = "\(hexagram.id). \(hexagram.englishName)"
        content.body = "\(hexagram.chineseName) (\(hexagram.pinyin)) - Tap to explore today's wisdom."
        content.sound = .default
        content.userInfo = ["hexagramId": hexagram.id]
        
        // Extract hour and minute from the time
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: time)
        
        var dateComponents = DateComponents()
        dateComponents.hour = components.hour
        dateComponents.minute = components.minute
        
        // Create trigger for daily repetition
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        
        // Create request
        let request = UNNotificationRequest(
            identifier: "daily-hexagram",
            content: content,
            trigger: trigger
        )
        
        do {
            try await UNUserNotificationCenter.current().add(request)
        } catch {
            print("Failed to schedule daily hexagram: \(error)")
        }
    }
    
    func cancelDailyNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: ["daily-hexagram"]
        )
    }
}
