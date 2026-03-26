import Foundation
#if os(iOS)
import UIKit
#endif

@MainActor enum HapticService {
    /// Set to false to disable all haptic feedback (respects AppSettings.hapticFeedbackEnabled)
    static var isEnabled: Bool = true

    static func impact(_ style: ImpactStyle) {
        guard isEnabled else { return }
        #if os(iOS)
        let generator: UIImpactFeedbackGenerator
        switch style {
        case .light:
            generator = UIImpactFeedbackGenerator(style: .light)
        case .medium:
            generator = UIImpactFeedbackGenerator(style: .medium)
        case .heavy:
            generator = UIImpactFeedbackGenerator(style: .heavy)
        case .soft:
            generator = UIImpactFeedbackGenerator(style: .soft)
        case .rigid:
            generator = UIImpactFeedbackGenerator(style: .rigid)
        }
        generator.impactOccurred()
        #endif
    }
    
    static func notification(_ type: NotificationType) {
        guard isEnabled else { return }
        #if os(iOS)
        let generator = UINotificationFeedbackGenerator()
        switch type {
        case .success:
            generator.notificationOccurred(.success)
        case .warning:
            generator.notificationOccurred(.warning)
        case .error:
            generator.notificationOccurred(.error)
        }
        #endif
    }
    
    static func selection() {
        guard isEnabled else { return }
        #if os(iOS)
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        #endif
    }
    
    enum ImpactStyle {
        case light, medium, heavy, soft, rigid
    }
    
    enum NotificationType {
        case success, warning, error
    }
}
