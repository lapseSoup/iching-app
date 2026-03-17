import SwiftUI
import SwiftData

struct ReadingDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let reading: Reading
    
    @State private var showingJournalEditor = false
    @State private var selectedTab = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerSection
                hexagramSection
                
                if reading.hasChangingLines {
                    changingLinesSection
                    relatingHexagramSection
                }
                
                tabSection
                journalSection
            }
            .padding()
        }
        .navigationTitle("Reading")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingJournalEditor = true
                } label: {
                    Label("Add Reflection", systemImage: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showingJournalEditor) {
            JournalEditorView(reading: reading)
        }
    }
    
    // MARK: - Header
    
    private var headerSection: some View {
        VStack(spacing: 8) {
            if !reading.question.isEmpty {
                Text(reading.question)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            
            HStack(spacing: 16) {
                Label(reading.formattedDate, systemImage: "calendar")
                Label(reading.method.displayName, systemImage: reading.method.icon)
            }
            .font(.caption)
            .foregroundStyle(.tertiary)
        }
    }
    
    // MARK: - Primary Hexagram
    
    private var hexagramSection: some View {
        VStack(spacing: 20) {
            if let hexagram = reading.primaryHexagram {
                HexagramView(hexagram: hexagram, changingLines: reading.changingLinePositions)
                    .frame(height: 200)
                
                VStack(spacing: 8) {
                    Text("Hexagram \(hexagram.id)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text(hexagram.englishName)
                        .font(.title.weight(.semibold))
                    
                    HStack(spacing: 12) {
                        Text(hexagram.chineseName)
                            .font(.title2)
                        Text(hexagram.pinyin)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.cardBackground)
        )
    }
    
    // MARK: - Changing Lines
    
    private var changingLinesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Changing Lines", systemImage: "arrow.triangle.swap")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            ForEach(Array(reading.changingLinePositions).sorted(), id: \.self) { position in
                if let hexagram = reading.primaryHexagram,
                   let lineMeaning = hexagram.lineTexts.first(where: { $0.position == position }) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Line \(position)")
                                .font(.subheadline.weight(.semibold))
                            
                            let line = reading.lines[position - 1]
                            Text("\(line.value.changingSymbol ?? "") (\(line.value == .oldYang ? "Yang → Yin" : "Yin → Yang"))")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Text(lineMeaning.text)
                            .font(.body)
                            .italic()
                        
                        Text(lineMeaning.interpretation)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.tertiaryBackground)
                    )
                }
            }
        }
    }
    
    // MARK: - Relating Hexagram
    
    private var relatingHexagramSection: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "arrow.right")
                Text("Transforms Into")
                    .font(.headline)
            }
            .foregroundStyle(.secondary)
            
            if let relating = reading.relatingHexagram {
                NavigationLink(value: relating) {
                    HStack(spacing: 16) {
                        Text(relating.character)
                            .font(.system(size: 48))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hexagram \(relating.id)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text(relating.englishName)
                                .font(.headline)
                            
                            Text("\(relating.chineseName) • \(relating.pinyin)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.tertiary)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.cardBackground)
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .navigationDestination(for: Hexagram.self) { hexagram in
            HexagramDetailView(hexagram: hexagram)
        }
    }
    
    // MARK: - Tab Section (Judgment, Image, Commentary)

    private var tabSection: some View {
        Group {
            if let hexagram = reading.primaryHexagram {
                HexagramTextTabView(hexagram: hexagram, selectedTab: $selectedTab)
            }
        }
    }
    
    // MARK: - Journal Section
    
    private var journalSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("Reflections", systemImage: "book.closed")
                    .font(.headline)
                
                Spacer()
                
                Button {
                    showingJournalEditor = true
                } label: {
                    Image(systemName: "plus.circle")
                }
            }
            .foregroundStyle(.secondary)
            
            if reading.journalEntries.isEmpty {
                Text("No reflections yet. Tap + to add your thoughts.")
                    .font(.subheadline)
                    .foregroundStyle(.tertiary)
                    .padding()
            } else {
                ForEach(reading.journalEntries.sorted(by: { $0.createdAt > $1.createdAt })) { entry in
                    NavigationLink(value: entry) {
                        JournalEntryRow(entry: entry)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationDestination(for: JournalEntry.self) { entry in
            JournalEntryDetailView(entry: entry)
        }
    }
}

#Preview {
    do {
        let container = try ModelContainer(for: Reading.self, configurations: .init(isStoredInMemoryOnly: true))
        let reading = Reading(question: "What should I focus on?", lines: [.youngYang, .oldYin, .youngYin, .youngYang, .oldYang, .youngYin])
        container.mainContext.insert(reading)

        return NavigationStack {
            ReadingDetailView(reading: reading)
        }
        .modelContainer(container)
    } catch {
        return Text("Preview failed: \(error.localizedDescription)")
    }
}
