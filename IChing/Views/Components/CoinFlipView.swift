import SwiftUI

/// Animated 3D coin flip view
struct CoinFlipView: View {
    let coins: [Bool] // true = heads
    let isFlipping: Bool
    let onFlip: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 20) {
                ForEach(0..<3, id: \.self) { index in
                    CoinView(
                        isHeads: index < coins.count ? coins[index] : false,
                        isFlipping: isFlipping,
                        delay: Double(index) * 0.05
                    )
                    .accessibilityLabel("Coin \(index + 1): \(index < coins.count && coins[index] ? "heads" : "tails")")
                }
            }
            .accessibilityElement(children: .combine)
            
            if !isFlipping {
                let heads = coins.filter { $0 }.count
                VStack(spacing: 8) {
                    Text("\(heads) heads, \(3 - heads) tails")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    let lineValue = LineValue.from(heads: heads)
                    Text(lineDescription(for: lineValue))
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }
            }
            
            Button {
                onFlip()
            } label: {
                HStack {
                    Image(systemName: "arrow.triangle.2.circlepath")
                    Text(isFlipping ? "Flipping..." : "Flip Coins")
                }
                .font(.headline)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(
                    Capsule()
                        .fill(isFlipping ? Color.gray : Color.accentColor)
                )
                .foregroundColor(.white)
            }
            .disabled(isFlipping)
            .accessibilityHint(isFlipping ? "Coins are being flipped" : "Double tap to flip three coins")
        }
    }
    
    private func lineDescription(for value: LineValue) -> String {
        switch value {
        case .oldYin: return "6 - Old Yin (changing)"
        case .youngYang: return "7 - Young Yang"
        case .youngYin: return "8 - Young Yin"
        case .oldYang: return "9 - Old Yang (changing)"
        }
    }
}

/// Individual coin with 3D flip animation
struct CoinView: View {
    let isHeads: Bool
    let isFlipping: Bool
    var delay: Double = 0
    
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            // Coin face
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.85, green: 0.75, blue: 0.55),
                            Color(red: 0.75, green: 0.65, blue: 0.45),
                            Color(red: 0.85, green: 0.75, blue: 0.55)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    Circle()
                        .stroke(
                            Color(red: 0.65, green: 0.55, blue: 0.35),
                            lineWidth: 2
                        )
                )
                .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
            
            // Symbol
            Text(isHeads ? "龍" : "鳳")
                .font(.system(size: 24, weight: .bold, design: .serif))
                .foregroundStyle(
                    Color(red: 0.55, green: 0.45, blue: 0.25)
                )
                .scaleEffect(x: rotation.truncatingRemainder(dividingBy: 360) > 90 && 
                              rotation.truncatingRemainder(dividingBy: 360) < 270 ? -1 : 1)
        }
        .frame(width: 60, height: 60)
        .rotation3DEffect(
            .degrees(rotation),
            axis: (x: 1, y: 0.2, z: 0),
            perspective: 0.5
        )
        .onChange(of: isFlipping) { _, flipping in
            if flipping {
                withAnimation(
                    .easeInOut(duration: 0.1)
                        .repeatCount(8, autoreverses: false)
                        .delay(delay)
                ) {
                    rotation += 360
                }
            }
        }
        .onChange(of: isHeads) { _, _ in
            if !isFlipping {
                withAnimation(.spring(response: 0.3)) {
                    rotation = isHeads ? 0 : 180
                }
            }
        }
    }
}

#Preview {
    VStack {
        CoinFlipView(
            coins: [true, false, true],
            isFlipping: false,
            onFlip: {}
        )
    }
    .padding()
}
