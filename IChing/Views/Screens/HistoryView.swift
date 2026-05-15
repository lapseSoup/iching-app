import SwiftUI
import SwiftData
import os

/// Groups readings by date category (Today, Yesterday, This Week, This Month, or month/year)
/// and sorts by chronological order with predefined groups first.
/// - Parameter referenceDate: The date to compare against (defaults to now; pass explicitly for deterministic testing).
func groupReadingsByDate(_ readings: [Reading], referenceDate: Date = Date()) -> [(String, [Reading])] {
    let calendar = Calendar.current
    let grouped = Dictionary(grouping: readings) { reading -> String in
        if calendar.isDateInToday(reading.createdAt) {
            return "Today"
        } else if calendar.isDateInYesterday(reading.createdAt) {
            return "Yesterday"
        } else if calendar.isDate(reading.createdAt, equalTo: referenceDate, toGranularity: .weekOfYear) {
            return "This Week"
        } else if calendar.isDate(reading.createdAt, equalTo: referenceDate, toGranularity: .month) {
            return "This Month"
        } else {
            return DateFormatters.monthYear.string(from: reading.createdAt)
        }
    }

    let order = ["Today", "Yesterday", "This Week", "This Month"]
    return grouped.sorted { a, b in
        let aIndex = order.firstIndex(of: a.key) ?? Int.max
        let bIndex = order.firstIndex(of: b.key) ?? Int.max
        if aIndex != Int.max || bIndex != Int.max {
            return aIndex < bIndex
        }
        return (a.value.first?.createdAt ?? Date()) > (b.value.first?.createdAt ?? Date())
    }
}

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var showingSettings: Bool
    @Query(sort: \Reading.createdAt, order: .reverse) private var readings: [Reading]

    @State private var searchText = ""
    @State private var deleteError: String?
    @State private var groupedReadings: [(String, [Reading])] = []
    /// B-57: tracks whether `groupedReadings` has been seeded at least once so the
    /// initial render doesn't flash an empty list while .onAppear is pending.
    @State private var hasComputedGroups = false

    init(showingSettings: Binding<Bool> = .constant(false)) {
        _showingSettings = showingSettings
    }

    private var filteredReadings: [Reading] {
        if searchText.isEmpty {
            return readings
        }
        return readings.filter { reading in
            reading.question.localizedCaseInsensitiveContains(searchText) ||
            (reading.primaryHexagram?.englishName.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }

    private func recomputeGroupedReadings() {
        groupedReadings = groupReadingsByDate(filteredReadings)
        hasComputedGroups = true
    }

    var body: some View {
        NavigationStack {
            Group {
                if readings.isEmpty {
                    emptyState
                } else if hasComputedGroups {
                    readingsList
                } else {
                    // First render: compute synchronously so we never show an empty
                    // List inside the non-empty branch.
                    Color.clear.onAppear { recomputeGroupedReadings() }
                }
            }
            .navigationTitle("History")
            .searchable(text: $searchText, prompt: "Search readings")
            .errorAlert($deleteError, title: "Delete Error")
            .settingsToolbarButton(showingSettings: $showingSettings)
            .onChange(of: readings) { recomputeGroupedReadings() }
            .onChange(of: searchText) { recomputeGroupedReadings() }
        }
    }

    private var emptyState: some View {
        ContentUnavailableView(
            "No Readings Yet",
            systemImage: "clock",
            description: Text("Your reading history will appear here")
        )
    }

    private var readingsList: some View {
        List {
            ForEach(groupedReadings, id: \.0) { section in
                Section(section.0) {
                    ForEach(section.1) { reading in
                        NavigationLink(value: reading) {
                            ReadingRow(reading: reading)
                        }
                    }
                    .onDelete { indexSet in
                        deleteReadings(at: indexSet, in: section.1)
                    }
                }
            }
        }
        #if os(iOS)
        .listStyle(.insetGrouped)
        #endif
        .navigationDestination(for: Reading.self) { reading in
            ReadingDetailView(reading: reading)
        }
        .navigationDestination(for: Hexagram.self) { hexagram in
            HexagramDetailView(hexagram: hexagram)
        }
        .navigationDestination(for: JournalEntry.self) { entry in
            JournalEntryDetailView(entry: entry)
        }
    }

    private func deleteReadings(at offsets: IndexSet, in readings: [Reading]) {
        for index in offsets {
            modelContext.delete(readings[index])
        }
        modelContext.safeSave(operation: "delete readings") { error in
            deleteError = IChingError.deleteFailed(underlying: error).localizedDescription
        }
    }
}

struct ReadingRow: View {
    let reading: Reading
    
    var body: some View {
        HStack(spacing: 16) {
            // Hexagram symbol
            if let hexagram = reading.primaryHexagram {
                Text(hexagram.character)
                    .font(.system(size: 32))
                    .frame(width: 50)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if let hexagram = reading.primaryHexagram {
                    Text(hexagram.englishName)
                        .font(.headline)
                }
                
                if !reading.question.isEmpty {
                    Text(reading.question)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                
                HStack(spacing: 8) {
                    Text(reading.shortDate)
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                    
                    if reading.hasChangingLines {
                        Text("→ \(reading.relatingHexagram?.englishName ?? "")")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
            Spacer()
            
            // Journal indicator
            if !reading.journalEntries.isEmpty {
                Image(systemName: "note.text")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(readingAccessibilityLabel)
    }

    private var readingAccessibilityLabel: String {
        var parts: [String] = []
        if let hexagram = reading.primaryHexagram {
            parts.append(hexagram.englishName)
        }
        parts.append(reading.shortDate)
        if !reading.question.isEmpty {
            parts.append(reading.question)
        }
        if reading.hasChangingLines, let relating = reading.relatingHexagram {
            parts.append("changing to \(relating.englishName)")
        }
        return parts.joined(separator: ", ")
    }
}

#Preview {
    HistoryView()
        .modelContainer(for: [Reading.self], inMemory: true)
}
