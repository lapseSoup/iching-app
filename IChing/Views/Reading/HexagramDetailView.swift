import SwiftUI

struct HexagramDetailView: View {
    let hexagram: Hexagram

    @Environment(\.settings) private var settings

    private var showChinese: Bool { settings.showChineseCharacters }
    private var showPinyin: Bool { settings.showPinyin }

    @State private var selectedTab: HexagramTextSection = .judgment
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerSection
                trigramSection
                tabSection
                linesSection
            }
            .padding()
        }
        .navigationTitle("Hexagram \(hexagram.id)")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
    
    // MARK: - Header
    
    private var headerSection: some View {
        HexagramHeaderCard(
            hexagram: hexagram,
            showChineseCharacters: showChinese,
            showPinyin: showPinyin,
            showCharacter: true
        )
    }
    
    // MARK: - Trigrams
    
    private var trigramSection: some View {
        HStack(spacing: 24) {
            trigramCard(trigram: hexagram.upperTrigram, position: "Upper")
            trigramCard(trigram: hexagram.lowerTrigram, position: "Lower")
        }
    }
    
    private func trigramCard(trigram: Trigram, position: String) -> some View {
        VStack(spacing: 8) {
            Text(position)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text(trigram.symbol)
                .font(.system(size: 32))
            
            VStack(spacing: 2) {
                Text(trigram.englishName)
                    .font(.subheadline.weight(.medium))
                
                Text(showChinese ? "\(trigram.chineseName) • \(trigram.element)" : trigram.element)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.tertiaryBackground)
        )
    }
    
    // MARK: - Tab Section

    private var tabSection: some View {
        HexagramTextTabView(hexagram: hexagram, selectedTab: $selectedTab, showSectionHeaders: true)
    }
    
    // MARK: - Lines Section
    
    private var linesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("The Lines")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            ForEach(hexagram.lineTexts.reversed()) { lineMeaning in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Line \(lineMeaning.position)")
                            .font(.subheadline.weight(.semibold))
                        
                        let isYang = hexagram.lines[lineMeaning.position - 1]
                        Text(isYang ? "━━━━━ Yang" : "━━ ━━ Yin")
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
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.tertiaryBackground)
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        HexagramDetailView(hexagram: HexagramLibrary.shared.hexagram(number: 1)!)
    }
}
