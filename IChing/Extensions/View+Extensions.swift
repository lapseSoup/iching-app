import SwiftUI

extension View {
    /// Apply a card style background
    func cardStyle() -> some View {
        self
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.secondarySystemBackground))
            )
    }
    
    /// Apply a subtle shadow
    func softShadow() -> some View {
        self
            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
    
    /// Conditionally apply a modifier
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Apply platform-specific modifiers
    #if os(iOS)
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    #endif
}

// MARK: - Animation Extensions

extension Animation {
    static let smoothSpring = Animation.spring(response: 0.4, dampingFraction: 0.75)
    static let quickSpring = Animation.spring(response: 0.3, dampingFraction: 0.7)
    static let gentleSpring = Animation.spring(response: 0.5, dampingFraction: 0.8)
}

// MARK: - Accessibility

extension View {
    func accessibleCard(label: String) -> some View {
        self
            .accessibilityElement(children: .combine)
            .accessibilityLabel(label)
    }
}
