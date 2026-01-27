import SwiftUI

/// A beautiful visualization of a hexagram with optional changing line indicators
struct HexagramView: View {
    let hexagram: Hexagram
    let changingLines: Set<Int>
    var lineSpacing: CGFloat = 12
    var lineHeight: CGFloat = 8
    var showLabels: Bool = true
    
    var body: some View {
        VStack(spacing: lineSpacing) {
            ForEach((1...6).reversed(), id: \.self) { position in
                HStack(spacing: 8) {
                    if showLabels {
                        // Changing line indicator
                        if changingLines.contains(position) {
                            let isOldYang = hexagram.lines[position - 1]
                            Text(isOldYang ? "○" : "×")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundStyle(Color.accentColor)
                                .frame(width: 16)
                        } else {
                            Color.clear.frame(width: 16)
                        }
                    }
                    
                    // Line
                    LineView(
                        isYang: hexagram.lines[position - 1],
                        isChanging: changingLines.contains(position),
                        height: lineHeight
                    )
                    
                    if showLabels {
                        // Position label
                        Text("\(position)")
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                            .frame(width: 16)
                    }
                }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityDescription)
    }
    
    private var accessibilityDescription: String {
        var desc = "Hexagram \(hexagram.id), \(hexagram.englishName)."
        if !changingLines.isEmpty {
            let positions = changingLines.sorted().map { String($0) }.joined(separator: ", ")
            desc += " Changing lines at positions \(positions)."
        }
        return desc
    }
}

/// A single line of a hexagram
struct LineView: View {
    let isYang: Bool
    var isChanging: Bool = false
    var height: CGFloat = 8
    
    var body: some View {
        Group {
            if isYang {
                // Solid yang line
                RoundedRectangle(cornerRadius: height / 2)
                    .fill(lineColor)
            } else {
                // Broken yin line
                HStack(spacing: height) {
                    RoundedRectangle(cornerRadius: height / 2)
                        .fill(lineColor)
                    RoundedRectangle(cornerRadius: height / 2)
                        .fill(lineColor)
                }
            }
        }
        .frame(height: height)
    }
    
    private var lineColor: Color {
        isChanging ? Color.accentColor : Color.primary
    }
}

/// View for building up a hexagram during divination
struct HexagramBuildingView: View {
    let lines: [LineValue]
    var lineSpacing: CGFloat = 10
    var lineHeight: CGFloat = 6
    
    var body: some View {
        VStack(spacing: lineSpacing) {
            ForEach((0..<6).reversed(), id: \.self) { index in
                Group {
                    if index < lines.count {
                        LineView(
                            isYang: lines[index].isYang,
                            isChanging: lines[index].isChanging,
                            height: lineHeight
                        )
                        .transition(.scale.combined(with: .opacity))
                    } else {
                        // Placeholder for undrawn lines
                        RoundedRectangle(cornerRadius: lineHeight / 2)
                            .fill(Color.secondary.opacity(0.15))
                            .frame(height: lineHeight)
                    }
                }
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: lines.count)
        .padding(.horizontal, 40)
    }
}

#Preview("Hexagram View") {
    VStack(spacing: 40) {
        HexagramView(
            hexagram: HexagramLibrary.shared.hexagram(number: 1)!,
            changingLines: [2, 5]
        )
        .frame(width: 200, height: 200)
        
        HexagramView(
            hexagram: HexagramLibrary.shared.hexagram(number: 2)!,
            changingLines: []
        )
        .frame(width: 200, height: 200)
    }
    .padding()
}

#Preview("Building View") {
    HexagramBuildingView(lines: [.youngYang, .oldYin, .youngYin])
        .frame(width: 200, height: 200)
        .padding()
}
