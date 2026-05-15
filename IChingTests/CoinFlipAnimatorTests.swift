import XCTest
@testable import IChing

@MainActor
final class CoinFlipAnimatorTests: XCTestCase {

    private var animator: CoinFlipAnimator!

    override func setUp() {
        super.setUp()
        animator = CoinFlipAnimator()
    }

    override func tearDown() {
        animator.stop()
        animator = nil
        super.tearDown()
    }

    // MARK: - isAnimating State

    func testStart_setsIsAnimatingTrue() {
        XCTAssertFalse(animator.isAnimating)
        animator.start()
        XCTAssertTrue(animator.isAnimating)
    }

    func testStop_setsIsAnimatingFalse() {
        animator.start()
        XCTAssertTrue(animator.isAnimating)
        animator.stop()
        XCTAssertFalse(animator.isAnimating)
    }

    func testStop_whenNotAnimating_doesNotCrash() {
        animator.stop()
        XCTAssertFalse(animator.isAnimating)
    }

    func testStart_calledTwice_remainsAnimating() {
        animator.start()
        animator.start()
        XCTAssertTrue(animator.isAnimating)
    }

    // MARK: - Intermediate Flip Callback

    func testOnIntermediateFlip_isCalledBeforeCompletion() {
        let flipExpectation = expectation(description: "intermediate flip called")
        flipExpectation.assertForOverFulfill = false

        animator.onIntermediateFlip = { coins in
            XCTAssertEqual(coins.count, 3)
            flipExpectation.fulfill()
        }
        animator.onComplete = { _ in }

        animator.start()
        wait(for: [flipExpectation], timeout: 3.0)
    }

    // MARK: - Completion Callback

    func testOnComplete_isCalledAfterAllFlips() {
        let completeExpectation = expectation(description: "onComplete called")

        animator.onComplete = { coins in
            XCTAssertEqual(coins.count, 3)
            completeExpectation.fulfill()
        }

        animator.start()
        wait(for: [completeExpectation], timeout: 3.0)
    }

    func testIsAnimating_falseAfterCompletion() {
        let completeExpectation = expectation(description: "onComplete called")

        animator.onComplete = { [weak self] _ in
            guard let self else { return }
            XCTAssertFalse(self.animator.isAnimating)
            completeExpectation.fulfill()
        }

        animator.start()
        wait(for: [completeExpectation], timeout: 3.0)
    }

    // MARK: - Flip Count

    func testIntermediateFlips_occurCorrectNumberOfTimes() {
        let completeExpectation = expectation(description: "onComplete called")
        var intermediateCount = 0

        animator.onIntermediateFlip = { coins in
            XCTAssertEqual(coins.count, 3)
            intermediateCount += 1
        }

        animator.onComplete = { _ in
            completeExpectation.fulfill()
        }

        animator.start()
        wait(for: [completeExpectation], timeout: 3.0)

        // flipCount is 8: flips 1-7 are intermediate, flip 8 triggers completion
        XCTAssertEqual(intermediateCount, 7)
    }

    // MARK: - Stop Cancels Animation

    func testStop_preventsCompletionCallback() {
        let completeExpectation = expectation(description: "onComplete should not be called")
        completeExpectation.isInverted = true

        animator.onComplete = { _ in
            completeExpectation.fulfill()
        }

        animator.start()
        animator.stop()

        // Wait briefly — the inverted expectation ensures onComplete is never called
        wait(for: [completeExpectation], timeout: 1.5)
    }

    // MARK: - Coins Are Boolean Arrays

    func testIntermediateFlip_returnsBoolArray() {
        let flipExpectation = expectation(description: "intermediate flip")
        flipExpectation.assertForOverFulfill = false

        animator.onIntermediateFlip = { coins in
            // Each coin is a Bool (heads/tails); verify the array structure
            XCTAssertEqual(coins.count, 3)
            flipExpectation.fulfill()
        }
        animator.onComplete = { _ in }

        animator.start()
        wait(for: [flipExpectation], timeout: 3.0)
    }

    func testComplete_returnsBoolArray() {
        let completeExpectation = expectation(description: "completion")

        animator.onComplete = { coins in
            XCTAssertEqual(coins.count, 3)
            completeExpectation.fulfill()
        }

        animator.start()
        wait(for: [completeExpectation], timeout: 3.0)
    }
}
