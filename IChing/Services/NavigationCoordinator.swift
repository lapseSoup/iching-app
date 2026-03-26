import SwiftUI
import Observation
import os

/// Protocol for navigation coordination — enables dependency injection and testing
@MainActor
protocol NavigationCoordinating: AnyObject {
    var pendingHexagramId: Int? { get set }
    func handle(url: URL)
    func consumePendingHexagram() -> Int?
}

/// Handles deep-link navigation from widgets and notifications
@MainActor @Observable
final class NavigationCoordinator: NavigationCoordinating {
    static let shared = NavigationCoordinator()

    private static let logger = Logger(subsystem: "com.iching.app", category: "NavigationCoordinator")

    var pendingHexagramId: Int?

    /// Internal init for dependency injection; use `shared` for production.
    init() {}

    /// Processes an incoming URL (e.g. iching://daily/42)
    func handle(url: URL) {
        guard url.scheme == "iching" else { return }

        if url.host == "daily" {
            if let idString = url.pathComponents.last, idString != "/",
               let id = Int(idString), (1...64).contains(id) {
                pendingHexagramId = id
            } else {
                Self.logger.info("Malformed deep link: \(url.absoluteString, privacy: .public) — path component is not a valid integer 1-64")
                // B-38: Fallback to today's daily hexagram for malformed deep links
                pendingHexagramId = HexagramBasicInfo.dailyHexagramId(for: Date())
            }
        }
    }

    /// Consumes the pending navigation, returning the hexagram ID if one was pending
    func consumePendingHexagram() -> Int? {
        defer { pendingHexagramId = nil }
        return pendingHexagramId
    }
}
