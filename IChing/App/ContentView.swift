import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
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
                NavigationStack {
                    tabContent(for: tab)
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    showingSettings = true
                                } label: {
                                    Image(systemName: "gearshape")
                                }
                            }
                        }
                }
                .tabItem {
                    Label(tab.rawValue, systemImage: tab.icon)
                }
                .tag(tab)
            }
        }
        .tint(Color.accentColor)
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
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button {
                            showingSettings = true
                        } label: {
                            Image(systemName: "gearshape")
                        }
                    }
                }
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
        #endif
    }
    
    @ViewBuilder
    private func tabContent(for tab: Tab) -> some View {
        switch tab {
        case .divine:
            DivineView()
        case .library:
            LibraryView()
        case .history:
            HistoryView()
        case .journal:
            JournalListView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Reading.self, JournalEntry.self, AppSettings.self], inMemory: true)
}
