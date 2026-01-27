import SwiftUI
import SwiftData

struct JournalListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JournalEntry.createdAt, order: .reverse) private var entries: [JournalEntry]
    
    @State private var searchText = ""
    
    private var filteredEntries: [JournalEntry] {
        if searchText.isEmpty {
            return entries
        }
        return entries.filter { entry in
            entry.content.localizedCaseInsensitiveContains(searchText)
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
        .listStyle(.insetGrouped)
        .navigationDestination(for: JournalEntry.self) { entry in
            JournalEntryDetailView(entry: entry)
        }
    }
    
    private func deleteEntries(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(filteredEntries[index])
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
    }
}

#Preview {
    JournalListView()
        .modelContainer(for: [JournalEntry.self, Reading.self], inMemory: true)
}
