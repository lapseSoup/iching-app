import SwiftUI

struct LibraryView: View {
    @Binding var showingSettings: Bool
    @State private var searchText = ""
    @State private var path = NavigationPath()
    @State private var filteredHexagrams: [Hexagram] = []

    @Environment(\.settingsManager) private var settingsManager
    @Environment(\.navigationCoordinator) private var navigationCoordinator
    @Environment(\.services) private var services

    private var hexagramRepository: any HexagramRepository { services.hexagrams }

    private var showChineseCharacters: Bool {
        settingsManager?.showChineseCharacters ?? true
    }

    init(showingSettings: Binding<Bool> = .constant(false)) {
        _showingSettings = showingSettings
    }

    private var hexagrams: [Hexagram] { hexagramRepository.hexagrams }

    private func recomputeFiltered() {
        if searchText.isEmpty {
            filteredHexagrams = hexagrams
        } else {
            filteredHexagrams = hexagrams.filter { hex in
                hex.englishName.localizedCaseInsensitiveContains(searchText) ||
                hex.chineseName.contains(searchText) ||
                hex.pinyin.localizedCaseInsensitiveContains(searchText) ||
                String(hex.id).contains(searchText)
            }
        }
    }

    /// Consumes any pending deep-link hexagram and pushes it onto the navigation path.
    /// B-56: called from both `.onAppear` (handles cold-start / macOS-switch) and
    /// `.onChange` (handles deep links arriving while the view is already visible).
    private func consumePendingNavigation() {
        if let id = navigationCoordinator.consumePendingHexagram(),
           let hexagram = hexagramRepository.hexagram(number: id) {
            path.append(hexagram)
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 140, maximum: 180), spacing: 16)
                ], spacing: 16) {
                    ForEach(filteredHexagrams) { hexagram in
                        NavigationLink(value: hexagram) {
                            HexagramCard(
                                hexagram: hexagram,
                                showChineseCharacters: showChineseCharacters
                            )
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Hexagram \(hexagram.id), \(hexagram.englishName), \(hexagram.chineseName)")
                    }
                }
                .padding()
            }
            .navigationTitle("Library")
            .searchable(text: $searchText, prompt: "Search hexagrams")
            .settingsToolbarButton(showingSettings: $showingSettings)
            .navigationDestination(for: Hexagram.self) { hexagram in
                HexagramDetailView(hexagram: hexagram)
            }
            .onAppear {
                recomputeFiltered()
                consumePendingNavigation()
            }
            .onChange(of: searchText) { recomputeFiltered() }
            .onChange(of: navigationCoordinator.pendingHexagramId) { _, _ in
                consumePendingNavigation()
            }
        }
    }
}

struct HexagramCard: View {
    let hexagram: Hexagram
    let showChineseCharacters: Bool

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

                if showChineseCharacters {
                    Text(hexagram.chineseName)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
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
