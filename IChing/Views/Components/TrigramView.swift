import SwiftUI

/// A visualization of a single trigram
struct TrigramView: View {
    let trigram: Trigram
    var lineSpacing: CGFloat = 6
    var lineHeight: CGFloat = 6
    var showLabel: Bool = true
    
    var body: some View {
        VStack(spacing: lineSpacing) {
            // Lines (top to bottom in display, but stored bottom to top)
            ForEach((0..<3).reversed(), id: \.self) { index in
                LineView(
                    isYang: trigram.lines[index],
                    height: lineHeight
                )
            }
            
            if showLabel {
                VStack(spacing: 2) {
                    Text(trigram.symbol)
                        .font(.title2)
                    
                    Text(trigram.chineseName)
                        .font(.caption)
                    
                    Text(trigram.englishName)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 4)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(trigram.englishName), \(trigram.element)")
    }
}

/// Grid showing all eight trigrams
struct TrigramGridView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(Trigram.allCases) { trigram in
                TrigramView(trigram: trigram)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview("Single Trigram") {
    VStack(spacing: 40) {
        TrigramView(trigram: .heaven)
            .frame(width: 100)
        
        TrigramView(trigram: .earth)
            .frame(width: 100)
        
        TrigramView(trigram: .water)
            .frame(width: 100)
    }
    .padding()
}

#Preview("Trigram Grid") {
    TrigramGridView()
        .padding()
}
