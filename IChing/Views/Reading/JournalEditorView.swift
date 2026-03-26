import SwiftUI
import SwiftData
import os

struct JournalEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    let reading: Reading
    var existingEntry: JournalEntry?
    
    @State private var content: String = ""
    @State private var selectedMood: Mood?
    @State private var saveError: String?
    
    private var isEditing: Bool { existingEntry != nil }
    
    init(reading: Reading, existingEntry: JournalEntry? = nil) {
        self.reading = reading
        self.existingEntry = existingEntry
        _content = State(initialValue: existingEntry?.content ?? "")
        _selectedMood = State(initialValue: existingEntry?.mood)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextEditor(text: $content)
                        .frame(minHeight: 200)
                        .onChange(of: content) { _, newValue in
                            if newValue.count > 10_000 {
                                content = String(newValue.prefix(10_000))
                            }
                        }
                } header: {
                    Text("Your Reflection")
                } footer: {
                    if let hexagram = reading.primaryHexagram {
                        Text("Reflecting on \(hexagram.englishName) • \(content.count)/10,000")
                    } else {
                        Text("\(content.count)/10,000")
                    }
                }
                
                Section("Mood") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(Mood.allCases) { mood in
                                moodButton(mood)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle(isEditing ? "Edit Reflection" : "Add Reflection")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                    }
                    .disabled(content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .errorAlert($saveError, title: "Save Error")
        }
    }
    
    private func moodButton(_ mood: Mood) -> some View {
        Button {
            if selectedMood == mood {
                selectedMood = nil
            } else {
                selectedMood = mood
            }
        } label: {
            VStack(spacing: 4) {
                Text(mood.emoji)
                    .font(.title2)
                Text(mood.displayName)
                    .font(.caption2)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(selectedMood == mood ? 
                          Color.accentColor.opacity(0.2) : 
                          Color.tertiaryBackground)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(selectedMood == mood ? Color.accentColor : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(selectedMood == mood ? .isSelected : [])
        .accessibilityLabel("\(mood.displayName) mood")
    }
    
    private func save() {
        if let entry = existingEntry {
            entry.update(content: content, mood: selectedMood)
        } else {
            let entry = JournalEntry(content: content, mood: selectedMood, reading: reading)
            modelContext.insert(entry)
        }

        do {
            try modelContext.save()
            dismiss()
        } catch {
            modelContext.rollback()
            AppLogger.persistence.error("Failed to save journal entry: \(error.localizedDescription, privacy: .private)")
            saveError = IChingError.saveFailed(underlying: error).localizedDescription
        }
    }
}

struct JournalEntryDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    let entry: JournalEntry
    
    @State private var showingEditor = false
    @State private var showingDeleteAlert = false
    @State private var deleteError: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                HStack {
                    if let mood = entry.mood {
                        Text(mood.emoji)
                            .font(.title)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(entry.formattedDate)
                            .font(.headline)
                        
                        if entry.isEdited {
                            Text("Edited")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                // Content
                Text(entry.content)
                    .font(.body)
                
                // Associated reading
                if let reading = entry.reading, let hexagram = reading.primaryHexagram {
                    Divider()
                    
                    NavigationLink(value: reading) {
                        HStack(spacing: 12) {
                            Text(hexagram.character)
                                .font(.title)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("From Reading")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text(hexagram.englishName)
                                    .font(.subheadline.weight(.medium))
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tertiary)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.cardBackground)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .navigationTitle("Reflection")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    showingEditor = true
                } label: {
                    Image(systemName: "pencil")
                }
                .disabled(entry.reading == nil)

                Button(role: .destructive) {
                    showingDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .sheet(isPresented: $showingEditor) {
            if let reading = entry.reading {
                JournalEditorView(reading: reading, existingEntry: entry)
            }
        }
        .alert("Delete Reflection?", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                modelContext.delete(entry)
                do {
                    try modelContext.save()
                    dismiss()
                } catch {
                    modelContext.rollback()
                    AppLogger.persistence.error("Failed to delete journal entry: \(error.localizedDescription, privacy: .private)")
                    deleteError = IChingError.deleteFailed(underlying: error).localizedDescription
                }
            }
        } message: {
            Text("This cannot be undone.")
        }
        .errorAlert($deleteError, title: "Delete Error")
        .navigationDestination(for: Reading.self) { reading in
            ReadingDetailView(reading: reading)
        }
    }
}

#Preview {
    do {
        let container = try ModelContainer(for: Reading.self, JournalEntry.self, configurations: .init(isStoredInMemoryOnly: true))
        let reading = Reading(question: "Test", lines: [.youngYang, .youngYin, .youngYang, .youngYin, .youngYang, .youngYin])
        container.mainContext.insert(reading)

        return NavigationStack {
            JournalEditorView(reading: reading)
        }
        .modelContainer(container)
    } catch {
        return Text("Preview failed: \(error.localizedDescription)")
    }
}
