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
    
    // Result
    var primaryHexagram: Hexagram? {
        guard completedLines.count == 6 else { return nil }
        return Hexagram.from(lineValues: completedLines)?.primary
    }
    
    var relatingHexagram: Hexagram? {
        guard completedLines.count == 6 else { return nil }
        return Hexagram.from(lineValues: completedLines)?.relating
    }
    
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
    }
    
    func flipCoins() {
        guard !isFlipping else { return }
        
        isFlipping = true
        
        // Animate coin flips
        let flipCount = 8
        var flips = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            flips += 1

            // Random intermediate states
            self.currentCoins = [
                Bool.random(),
                Bool.random(),
                Bool.random()
            ]

            HapticService.impact(.light)

            if flips >= flipCount {
                timer.invalidate()

                // Final result
                self.currentCoins = [
                    Bool.random(),
                    Bool.random(),
                    Bool.random()
                ]

                HapticService.notification(.success)

                self.isFlipping = false
                self.canProceed = true
            }
        }
    }
    
    func proceedToNextLine() {
        let heads = currentCoins.filter { $0 }.count
        let lineValue = LineValue.from(heads: heads)
        completedLines.append(lineValue)
        
        if currentLine >= 6 {
            state = .complete
        } else {
            currentLine += 1
            currentCoins = [false, false, false]
            canProceed = false
        }
    }
    
    func setManualLines(_ lines: [LineValue]) {
        completedLines = lines
        state = .complete
    }
    
    func reset() {
        state = .idle
        question = ""
        currentLine = 1
        completedLines = []
        currentCoins = [false, false, false]
        canProceed = false
        isFlipping = false
    }
}
