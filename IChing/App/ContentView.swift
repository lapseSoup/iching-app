import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var settingsArray: [AppSettings]
    @State private var selectedTab: Tab = .divine
    @State private var showingSettings = false

    private var preferredColorScheme: ColorScheme? {
        guard let settings = settingsArray.first else { return nil }
        switch settings.appColorScheme {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
    
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
        .preferredColorScheme(preferredColorScheme)
        .onAppear { ensureSettingsExist() }
        .onChange(of: NavigationCoordinator.shared.pendingHexagramId) { _, newValue in
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
        .preferredColorScheme(preferredColorScheme)
        .onAppear { ensureSettingsExist() }
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
        #endif
    }

    private func ensureSettingsExist() {
        if settingsArray.isEmpty {
            modelContext.insert(AppSettings())
        }
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
