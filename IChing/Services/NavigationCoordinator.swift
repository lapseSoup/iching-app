import SwiftUI
import Observation

/// Handles deep-link navigation from widgets and notifications
@MainActor @Observable
final class NavigationCoordinator {
    static let shared = NavigationCoordinator()

    var pendingHexagramId: Int?

    private init() {}

    /// Processes an incoming URL (e.g. iching://daily/42)
    func handle(url: URL) {
        guard url.scheme == "iching" else { return }

        if url.host == "daily", let idString = url.pathComponents.last, let id = Int(idString), (1...64).contains(id) {
            pendingHexagramId = id
        }
    }

    /// Consumes the pending navigation, returning the hexagram ID if one was pending
    func consumePendingHexagram() -> Int? {
        defer { pendingHexagramId = nil }
        return pendingHexagramId
    }
}
