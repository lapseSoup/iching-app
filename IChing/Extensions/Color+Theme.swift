import SwiftUI

extension Color {
    /// Primary brand colors
    static let iChingAccent = Color("AccentColor")
    
    /// Semantic colors for the app
    static let yangColor = Color.primary
    static let yinColor = Color.secondary
    static let changingYang = Color.orange
    static let changingYin = Color.purple
    
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
}

extension ShapeStyle where Self == LinearGradient {
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
}
