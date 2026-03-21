import SwiftUI

extension Color {
    /// Background variants
    #if os(macOS)
    static let cardBackground = Color(nsColor: .controlBackgroundColor)
    static let tertiaryBackground = Color(nsColor: .underPageBackgroundColor)
    static let groupedBackground = Color(nsColor: .windowBackgroundColor)
    #else
    static let cardBackground = Color(.secondarySystemBackground)
    static let tertiaryBackground = Color(.tertiarySystemBackground)
    static let groupedBackground = Color(.systemGroupedBackground)
    #endif

    /// Coin border color
    static let coinBorder = Color(red: 0.65, green: 0.55, blue: 0.35)

    /// Coin symbol color
    static let coinSymbol = Color(red: 0.55, green: 0.45, blue: 0.25)
}

extension ShapeStyle where Self == LinearGradient {
    /// Gradient for backgrounds
    static var zenGradient: LinearGradient {
        #if os(macOS)
        let bgColor = Color(nsColor: .windowBackgroundColor)
        #else
        let bgColor = Color(.systemBackground)
        #endif
        return LinearGradient(
            colors: [bgColor, Color.accentColor.opacity(0.05)],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    /// Gradient for coin surfaces
    static var coinGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.85, green: 0.75, blue: 0.55),
                Color(red: 0.75, green: 0.65, blue: 0.45),
                Color(red: 0.85, green: 0.75, blue: 0.55)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
