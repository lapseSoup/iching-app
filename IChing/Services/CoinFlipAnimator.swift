import Foundation

/// Handles the coin flip animation timing, separated from ViewModel business logic.
/// This isolates the timer/haptic side-effects from the domain state management.
@MainActor
final class CoinFlipAnimator {
    private var timer: Timer?
    private let flipCount = 8
    private let interval: TimeInterval = 0.1

    var onIntermediateFlip: (([Bool]) -> Void)?
    var onComplete: (([Bool]) -> Void)?

    var isAnimating: Bool { timer != nil }

    func start() {
        stop()

        var flips = 0
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            guard let self else {
                timer.invalidate()
                return
            }

            flips += 1

            if flips >= self.flipCount {
                timer.invalidate()
                self.timer = nil

                let finalCoins = [Bool.random(), Bool.random(), Bool.random()]
                HapticService.notification(.success)
                self.onComplete?(finalCoins)
            } else {
                let coins = [Bool.random(), Bool.random(), Bool.random()]
                HapticService.impact(.light)
                self.onIntermediateFlip?(coins)
            }
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    deinit {
        timer?.invalidate()
    }
}
