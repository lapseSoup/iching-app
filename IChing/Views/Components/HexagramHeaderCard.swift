import SwiftUI

/// Reusable header card displaying a hexagram's visual representation and name details.
/// Used by both ReadingDetailView and HexagramDetailView.
struct HexagramHeaderCard: View {
    let hexagram: Hexagram
    var changingLines: Set<Int> = []
    var showChineseCharacters: Bool = true
    var showPinyin: Bool = true
    var showCharacter: Bool = false

    var body: some View {
        VStack(spacing: 16) {
            HexagramView(hexagram: hexagram, changingLines: changingLines)
                .frame(height: showCharacter ? 180 : 200)

            VStack(spacing: 8) {
                if showCharacter {
                    Text(hexagram.character)
                        .font(.system(size: 48))
                }

                Text("Hexagram \(hexagram.id)")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(hexagram.englishName)
                    .font(.title.weight(.semibold))

                if showChineseCharacters || showPinyin {
                    HStack(spacing: 12) {
                        if showChineseCharacters {
                            Text(hexagram.chineseName)
                                .font(.title2)
                        }
                        if showPinyin {
                            Text(hexagram.pinyin)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
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
}
