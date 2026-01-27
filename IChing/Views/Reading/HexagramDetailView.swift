import SwiftUI

struct HexagramDetailView: View {
    let hexagram: Hexagram
    
    @State private var selectedTab = 0
    
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
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Header
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            HexagramView(hexagram: hexagram, changingLines: [])
                .frame(height: 180)
            
            VStack(spacing: 8) {
                Text(hexagram.character)
                    .font(.system(size: 48))
                
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
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.secondarySystemBackground))
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
                
                Text("\(trigram.chineseName) • \(trigram.element)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.tertiarySystemBackground))
        )
    }
    
    // MARK: - Tab Section
    
    private var tabSection: some View {
        VStack(spacing: 16) {
            Picker("Section", selection: $selectedTab) {
                Text("Judgment").tag(0)
                Text("Image").tag(1)
                Text("Commentary").tag(2)
            }
            .pickerStyle(.segmented)
            
            VStack(alignment: .leading, spacing: 12) {
                switch selectedTab {
                case 0:
                    Text("The Judgment")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    Text(hexagram.judgment)
                        .font(.body)
                case 1:
                    Text("The Image")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    Text(hexagram.image)
                        .font(.body)
                default:
                    Text("Commentary")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    Text(hexagram.commentary)
                        .font(.body)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.secondarySystemBackground))
            )
        }
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
                        .fill(Color(.tertiarySystemBackground))
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
