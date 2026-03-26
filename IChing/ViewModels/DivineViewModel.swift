import SwiftUI
import Observation

@MainActor @Observable
final class DivineViewModel {
    enum State {
        case idle
        case flipping
        case complete
    }

    var state: State = .idle
    var question: String = ""
    var selectedMethod: ReadingMethod = .coinFlip

    // Coin flip state
    var currentLine: Int = 1
    var currentCoins: [Bool] = [false, false, false] // heads = true
    var isFlipping: Bool = false
    var completedLines: [LineValue] = []
    var canProceed: Bool = false
    var hasFlipped: Bool = false

    private let animator = CoinFlipAnimator()

    init() {
        animator.onIntermediateFlip = { [weak self] coins in
            self?.currentCoins = coins
        }
        animator.onComplete = { [weak self] coins in
            guard let self else { return }
            self.currentCoins = coins
            self.isFlipping = false
            self.canProceed = true
            self.hasFlipped = true
        }
    }

    // Cached hexagram result — set when all 6 lines are complete
    private var _cachedHexagramResult: (primary: Hexagram, relating: Hexagram?)?

    var primaryHexagram: Hexagram? { _cachedHexagramResult?.primary }
    var relatingHexagram: Hexagram? { _cachedHexagramResult?.relating }

    var changingLinePositions: Set<Int> {
        Set(completedLines.enumerated()
            .filter { $0.element.isChanging }
            .map { $0.offset + 1 })
    }

    func startReading() {
        state = .flipping
        currentLine = 1
        completedLines = []
        currentCoins = [false, false, false]
        canProceed = false
        hasFlipped = false
        _cachedHexagramResult = nil
    }

    func flipCoins() {
        guard state == .flipping, !isFlipping else { return }
        isFlipping = true
        animator.start()
    }

    func proceedToNextLine() {
        guard state == .flipping else { return }
        let heads = currentCoins.filter { $0 }.count
        let lineValue = LineValue.from(heads: heads)
        completedLines.append(lineValue)

        if currentLine >= 6 {
            state = .complete
            _cachedHexagramResult = Hexagram.from(lineValues: completedLines)
        } else {
            currentLine += 1
            currentCoins = [false, false, false]
            canProceed = false
            hasFlipped = false
        }
    }

    func setManualLines(_ lines: [LineValue]) {
        completedLines = lines
        state = .complete
        _cachedHexagramResult = Hexagram.from(lineValues: lines)
    }

    func reset() {
        animator.stop()
        state = .idle
        question = ""
        currentLine = 1
        completedLines = []
        currentCoins = [false, false, false]
        canProceed = false
        isFlipping = false
        hasFlipped = false
        _cachedHexagramResult = nil
    }
}
