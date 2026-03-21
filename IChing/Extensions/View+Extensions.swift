import SwiftUI

extension View {
    /// Conditionally apply a modifier
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    /// Adds a settings gear button to the toolbar (Q-25)
    func settingsToolbarButton(showingSettings: Binding<Bool>) -> some View {
        self.toolbar {
            #if os(iOS)
            ToolbarItem(placement: .topBarTrailing) {
                Button { showingSettings.wrappedValue = true } label: {
                    Image(systemName: "gearshape")
                }
            }
            #else
            ToolbarItem(placement: .automatic) {
                Button { showingSettings.wrappedValue = true } label: {
                    Image(systemName: "gearshape")
                }
            }
            #endif
        }
    }

    /// Presents an error alert with an OK button (Q-34)
    func errorAlert(_ errorMessage: Binding<String?>, title: String = "Error") -> some View {
        self.alert(title, isPresented: Binding(
            get: { errorMessage.wrappedValue != nil },
            set: { if !$0 { errorMessage.wrappedValue = nil } }
        )) {
            Button("OK") { errorMessage.wrappedValue = nil }
        } message: {
            Text(errorMessage.wrappedValue ?? "")
        }
    }
}
