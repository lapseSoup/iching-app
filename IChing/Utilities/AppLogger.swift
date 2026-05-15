import Foundation
import SwiftData
import os

enum AppLogger {
    static let general = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.iching.app", category: "general")
    static let persistence = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.iching.app", category: "persistence")
    static let navigation = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.iching.app", category: "navigation")
    static let notifications = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.iching.app", category: "notifications")
}

// MARK: - ModelContext convenience (A-49)

extension ModelContext {
    /// Saves pending changes; on failure, rolls back, logs to the supplied category,
    /// and invokes `onError` with the underlying error so callers can surface it.
    /// Encapsulates the rollback + log + alert pattern repeated across views.
    func safeSave(
        category: Logger = AppLogger.persistence,
        operation: StaticString = "save",
        onError: (Error) -> Void
    ) {
        do {
            try save()
        } catch {
            rollback()
            category.error("\(operation, privacy: .public) failed: \(error.localizedDescription, privacy: .private)")
            onError(error)
        }
    }
}
