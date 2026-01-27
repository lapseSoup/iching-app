import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Reading.createdAt, order: .reverse) private var readings: [Reading]
    
    @State private var searchText = ""
    
    private var filteredReadings: [Reading] {
        if searchText.isEmpty {
            return readings
        }
        return readings.filter { reading in
            reading.question.localizedCaseInsensitiveContains(searchText) ||
            (reading.primaryHexagram?.englishName.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }
    
    private var groupedReadings: [(String, [Reading])] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: filteredReadings) { reading -> String in
            if calendar.isDateInToday(reading.createdAt) {
                return "Today"
            } else if calendar.isDateInYesterday(reading.createdAt) {
                return "Yesterday"
            } else if calendar.isDate(reading.createdAt, equalTo: Date(), toGranularity: .weekOfYear) {
                return "This Week"
            } else if calendar.isDate(reading.createdAt, equalTo: Date(), toGranularity: .month) {
                return "This Month"
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM yyyy"
                return formatter.string(from: reading.createdAt)
            }
        }
        
        let order = ["Today", "Yesterday", "This Week", "This Month"]
        return grouped.sorted { a, b in
            let aIndex = order.firstIndex(of: a.key) ?? Int.max
            let bIndex = order.firstIndex(of: b.key) ?? Int.max
            if aIndex != Int.max || bIndex != Int.max {
                return aIndex < bIndex
            }
            return a.value.first?.createdAt ?? Date() > b.value.first?.createdAt ?? Date()
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if readings.isEmpty {
                    emptyState
                } else {
                    readingsList
                }
            }
            .navigationTitle("History")
            .searchable(text: $searchText, prompt: "Search readings")
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
        .listStyle(.insetGrouped)
        .navigationDestination(for: Reading.self) { reading in
            ReadingDetailView(reading: reading)
        }
    }
    
    private func deleteReadings(at offsets: IndexSet, in readings: [Reading]) {
        for index in offsets {
            modelContext.delete(readings[index])
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
    }
}

#Preview {
    HistoryView()
        .modelContainer(for: [Reading.self], inMemory: true)
}
