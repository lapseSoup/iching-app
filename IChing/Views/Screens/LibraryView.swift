import SwiftUI

struct LibraryView: View {
    @Binding var showingSettings: Bool
    @State private var searchText = ""
    @State private var selectedHexagram: Hexagram?

    init(showingSettings: Binding<Bool> = .constant(false)) {
        _showingSettings = showingSettings
    }
    
    private let hexagrams = HexagramLibrary.shared.hexagrams
    
    private var filteredHexagrams: [Hexagram] {
        if searchText.isEmpty {
            return hexagrams
        }
        return hexagrams.filter { hex in
            hex.englishName.localizedCaseInsensitiveContains(searchText) ||
            hex.chineseName.contains(searchText) ||
            hex.pinyin.localizedCaseInsensitiveContains(searchText) ||
            String(hex.id).contains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 140, maximum: 180), spacing: 16)
                ], spacing: 16) {
                    ForEach(filteredHexagrams) { hexagram in
                        NavigationLink(value: hexagram) {
                            HexagramCard(hexagram: hexagram)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Hexagram \(hexagram.id), \(hexagram.englishName), \(hexagram.chineseName)")
                    }
                }
                .padding()
            }
            .navigationTitle("Library")
            .searchable(text: $searchText, prompt: "Search hexagrams")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { showingSettings = true } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .navigationDestination(for: Hexagram.self) { hexagram in
                HexagramDetailView(hexagram: hexagram)
            }
        }
    }
}

struct HexagramCard: View {
    let hexagram: Hexagram
    
    var body: some View {
        VStack(spacing: 12) {
            // Hexagram symbol
            Text(hexagram.character)
                .font(.system(size: 40))
            
            VStack(spacing: 4) {
                Text("\(hexagram.id). \(hexagram.englishName)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                
                Text(hexagram.chineseName)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.cardBackground)
        )
    }
}

#Preview {
    LibraryView()
}
