import SwiftUI

struct ContentView: View {
    @Environment(\.settingsManager) private var settingsManager
    @Environment(\.navigationCoordinator) private var navigationCoordinator
    @State private var selectedTab: Tab = .divine
    @State private var showingSettings = false

    enum Tab: String, CaseIterable {
        case divine = "Divine"
        case library = "Library"
        case history = "History"
        case journal = "Journal"

        var icon: String {
            switch self {
            case .divine: return "sparkles"
            case .library: return "books.vertical"
            case .history: return "clock"
            case .journal: return "book.closed"
            }
        }
    }

    var body: some View {
        #if os(iOS)
        TabView(selection: $selectedTab) {
            ForEach(Tab.allCases, id: \.self) { tab in
                tabContent(for: tab)
                    .tabItem {
                        Label(tab.rawValue, systemImage: tab.icon)
                    }
                    .tag(tab)
            }
        }
        .tint(Color.accentColor)
        .preferredColorScheme(settingsManager?.preferredColorScheme)
        .onAppear { syncHapticState() }
        .onChange(of: navigationCoordinator.pendingHexagramId) { _, newValue in
            if newValue != nil {
                selectedTab = .library
            }
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
        #else
        NavigationSplitView {
            List(Tab.allCases, id: \.self, selection: $selectedTab) { tab in
                Label(tab.rawValue, systemImage: tab.icon)
                    .tag(tab)
            }
            .listStyle(.sidebar)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200, max: 250)
        } detail: {
            tabContent(for: selectedTab)
        }
        .preferredColorScheme(settingsManager?.preferredColorScheme)
        .onAppear { syncHapticState() }
        // B-55: macOS needs the same deep-link → Library switch the iOS branch already has.
        .onChange(of: navigationCoordinator.pendingHexagramId) { _, newValue in
            if newValue != nil {
                selectedTab = .library
            }
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
        #endif
    }

    /// Syncs the global `HapticService.isEnabled` static with the persisted setting.
    /// B-60: Calling the static directly is clearer than threading through the
    /// `any HapticServiceProtocol` existential when SettingsManager.hapticFeedbackEnabled
    /// setter already does the same delegation.
    private func syncHapticState() {
        guard let settingsManager else { return }
        HapticService.isEnabled = settingsManager.hapticFeedbackEnabled
    }

    @ViewBuilder
    private func tabContent(for tab: Tab) -> some View {
        switch tab {
        case .divine:
            DivineView(showingSettings: $showingSettings)
        case .library:
            LibraryView(showingSettings: $showingSettings)
        case .history:
            HistoryView(showingSettings: $showingSettings)
        case .journal:
            JournalListView(showingSettings: $showingSettings)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Reading.self, JournalEntry.self, AppSettings.self], inMemory: true)
}
