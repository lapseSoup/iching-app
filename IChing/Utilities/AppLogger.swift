import Foundation
import os

enum AppLogger {
    static let general = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.iching.app", category: "general")
    static let persistence = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.iching.app", category: "persistence")
    static let navigation = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.iching.app", category: "navigation")
    static let notifications = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.iching.app", category: "notifications")
}
