import Foundation

/// Handles the coin flip animation timing, separated from ViewModel business logic.
/// This isolates the timer/haptic side-effects from the domain state management.
@MainActor
final class CoinFlipAnimator {
    private var timer: Timer?
    private let flipCount = 8
    private let interval: TimeInterval = 0.1
    private let haptics: any HapticServiceProtocol

    var onIntermediateFlip: (([Bool]) -> Void)?
    var onComplete: (([Bool]) -> Void)?

    var isAnimating: Bool { timer != nil }

    init(haptics: any HapticServiceProtocol = HapticServiceAdapter()) {
        self.haptics = haptics
    }

    func start() {
        stop()

        var flips = 0
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            Task { @MainActor in
                guard let self else {
                    timer.invalidate()
                    return
                }
                // B-54: Guard against re-entry — under main-thread contention, multiple ticks
                // can enqueue tasks before any executes. Once we've reached flipCount we must
                // refuse further work or onComplete fires multiple times with fresh randomness.
                guard flips < self.flipCount else { return }

                flips += 1

                if flips >= self.flipCount {
                    timer.invalidate()
                    self.timer = nil

                    let finalCoins = [Bool.random(), Bool.random(), Bool.random()]
                    self.haptics.notification(.success)
                    self.onComplete?(finalCoins)
                } else {
                    let coins = [Bool.random(), Bool.random(), Bool.random()]
                    self.haptics.impact(.light)
                    self.onIntermediateFlip?(coins)
                }
            }
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

}
