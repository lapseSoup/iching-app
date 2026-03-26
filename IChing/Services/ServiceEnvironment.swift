import SwiftUI

// MARK: - HapticService Protocol & Environment

/// Protocol for haptic feedback — enables dependency injection and testing
@MainActor
protocol HapticServiceProtocol {
    var isEnabled: Bool { get set }
    func impact(_ style: HapticService.ImpactStyle)
    func notification(_ type: HapticService.NotificationType)
    func selection()
}

/// Makes HapticService (static enum) accessible via a wrapper that conforms to the protocol
@MainActor
final class HapticServiceAdapter: HapticServiceProtocol, Sendable {
    nonisolated init() {}
    var isEnabled: Bool {
        get { HapticService.isEnabled }
        set { HapticService.isEnabled = newValue }
    }

    func impact(_ style: HapticService.ImpactStyle) {
        HapticService.impact(style)
    }

    func notification(_ type: HapticService.NotificationType) {
        HapticService.notification(type)
    }

    func selection() {
        HapticService.selection()
    }
}

struct HapticServiceKey: EnvironmentKey {
    @MainActor static let defaultValue: any HapticServiceProtocol = HapticServiceAdapter()
}

extension EnvironmentValues {
    var hapticService: any HapticServiceProtocol {
        get { self[HapticServiceKey.self] }
        set { self[HapticServiceKey.self] = newValue }
    }
}

// MARK: - NavigationCoordinator Environment

/// Uses the concrete @Observable type so SwiftUI observation tracking works.
/// Tests can inject a different NavigationCoordinator instance.
struct NavigationCoordinatorKey: EnvironmentKey {
    @MainActor static let defaultValue: NavigationCoordinator = .shared
}

extension EnvironmentValues {
    var navigationCoordinator: NavigationCoordinator {
        get { self[NavigationCoordinatorKey.self] }
        set { self[NavigationCoordinatorKey.self] = newValue }
    }
}

// MARK: - NotificationService Protocol & Environment

/// Protocol for notification scheduling — enables dependency injection and testing
@MainActor
protocol NotificationServiceProtocol: AnyObject {
    var isAuthorized: Bool { get }
    func requestAuthorization() async -> Bool
    func checkAuthorizationStatus() async
    func scheduleDailyHexagram(at time: Date) async
    func cancelDailyNotifications()
}

extension NotificationService: NotificationServiceProtocol {}

struct NotificationServiceKey: EnvironmentKey {
    @MainActor static let defaultValue: any NotificationServiceProtocol = NotificationService.shared
}

extension EnvironmentValues {
    var notificationService: any NotificationServiceProtocol {
        get { self[NotificationServiceKey.self] }
        set { self[NotificationServiceKey.self] = newValue }
    }
}

// MARK: - HexagramRepository Environment

struct HexagramRepositoryKey: EnvironmentKey {
    static let defaultValue: any HexagramRepository = HexagramLibrary.shared
}

extension EnvironmentValues {
    var hexagramRepository: any HexagramRepository {
        get { self[HexagramRepositoryKey.self] }
        set { self[HexagramRepositoryKey.self] = newValue }
    }
}
