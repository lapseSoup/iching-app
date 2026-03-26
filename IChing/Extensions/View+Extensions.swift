import SwiftUI

extension View {
    /// Adds a settings gear button to the toolbar (Q-25)
    func settingsToolbarButton(showingSettings: Binding<Bool>) -> some View {
        self.toolbar {
            #if os(iOS)
            ToolbarItem(placement: .topBarTrailing) {
                Button { showingSettings.wrappedValue = true } label: {
                    Image(systemName: "gearshape")
                }
                .accessibilityLabel("Settings")
            }
            #else
            ToolbarItem(placement: .automatic) {
                Button { showingSettings.wrappedValue = true } label: {
                    Image(systemName: "gearshape")
                }
                .accessibilityLabel("Settings")
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
