import SwiftUI
import SwiftData
import os

struct JournalListView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var showingSettings: Bool
    @Query(sort: \JournalEntry.createdAt, order: .reverse) private var entries: [JournalEntry]

    @State private var searchText = ""
    @State private var deleteError: String?
    /// Q-63: memoized filter result. Recomputed only when entries or searchText change.
    @State private var filteredEntries: [JournalEntry] = []

    init(showingSettings: Binding<Bool> = .constant(false)) {
        _showingSettings = showingSettings
    }

    private func recomputeFilteredEntries() {
        if searchText.isEmpty {
            filteredEntries = entries
        } else {
            filteredEntries = entries.filter { entry in
                entry.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if entries.isEmpty {
                    emptyState
                } else {
                    entriesList
                }
            }
            .navigationTitle("Journal")
            .searchable(text: $searchText, prompt: "Search journal")
            .settingsToolbarButton(showingSettings: $showingSettings)
            .errorAlert($deleteError, title: "Delete Error")
            .onAppear { recomputeFilteredEntries() }
            .onChange(of: entries) { recomputeFilteredEntries() }
            .onChange(of: searchText) { recomputeFilteredEntries() }
        }
    }
    
    private var emptyState: some View {
        ContentUnavailableView(
            "No Journal Entries",
            systemImage: "book.closed",
            description: Text("Reflect on your readings to create journal entries")
        )
    }
    
    private var entriesList: some View {
        List {
            ForEach(filteredEntries) { entry in
                NavigationLink(value: entry) {
                    JournalEntryRow(entry: entry)
                }
            }
            .onDelete(perform: deleteEntries)
        }
        #if os(iOS)
        .listStyle(.insetGrouped)
        #endif
        .navigationDestination(for: JournalEntry.self) { entry in
            JournalEntryDetailView(entry: entry)
        }
    }
    
    private func deleteEntries(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(filteredEntries[index])
        }
        modelContext.safeSave(operation: "delete journal entries") { error in
            deleteError = IChingError.deleteFailed(underlying: error).localizedDescription
        }
    }
}

struct JournalEntryRow: View {
    let entry: JournalEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                if let mood = entry.mood {
                    Text(mood.emoji)
                }
                
                Text(entry.formattedDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                if entry.isEdited {
                    Text("(edited)")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
            }
            
            Text(entry.content)
                .font(.subheadline)
                .lineLimit(3)
            
            if let reading = entry.reading, let hexagram = reading.primaryHexagram {
                HStack(spacing: 4) {
                    Text(hexagram.character)
                        .font(.caption)
                    Text(hexagram.englishName)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(entryAccessibilityLabel)
    }

    private var entryAccessibilityLabel: String {
        var parts: [String] = [entry.formattedDate]
        if let mood = entry.mood {
            parts.append(mood.displayName)
        }
        let preview = entry.content.prefix(100)
        parts.append(String(preview))
        return parts.joined(separator: ", ")
    }
}

#Preview {
    JournalListView()
        .modelContainer(for: [JournalEntry.self, Reading.self], inMemory: true)
}
