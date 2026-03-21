import XCTest
@testable import IChing

@MainActor
final class DivineViewModelTests: XCTestCase {

    private var sut: DivineViewModel!

    override func setUp() {
        super.setUp()
        sut = DivineViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - 1. Initial State

    func testInitialState_isIdle() {
        XCTAssertEqual(sut.state, .idle)
    }

    func testInitialState_questionIsEmpty() {
        XCTAssertEqual(sut.question, "")
    }

    func testInitialState_selectedMethodIsCoinFlip() {
        XCTAssertEqual(sut.selectedMethod, .coinFlip)
    }

    func testInitialState_currentLineIsOne() {
        XCTAssertEqual(sut.currentLine, 1)
    }

    func testInitialState_currentCoinsAllFalse() {
        XCTAssertEqual(sut.currentCoins, [false, false, false])
    }

    func testInitialState_isFlippingIsFalse() {
        XCTAssertFalse(sut.isFlipping)
    }

    func testInitialState_completedLinesIsEmpty() {
        XCTAssertTrue(sut.completedLines.isEmpty)
    }

    func testInitialState_canProceedIsFalse() {
        XCTAssertFalse(sut.canProceed)
    }

    func testInitialState_hasFlippedIsFalse() {
        XCTAssertFalse(sut.hasFlipped)
    }

    func testInitialState_primaryHexagramIsNil() {
        XCTAssertNil(sut.primaryHexagram)
    }

    func testInitialState_relatingHexagramIsNil() {
        XCTAssertNil(sut.relatingHexagram)
    }

    func testInitialState_changingLinePositionsIsEmpty() {
        XCTAssertTrue(sut.changingLinePositions.isEmpty)
    }

    // MARK: - 2. startReading() State Changes

    func testStartReading_setsStateToFlipping() {
        sut.startReading()
        XCTAssertEqual(sut.state, .flipping)
    }

    func testStartReading_resetsCurrentLineToOne() {
        sut.currentLine = 4
        sut.startReading()
        XCTAssertEqual(sut.currentLine, 1)
    }

    func testStartReading_clearsCompletedLines() {
        sut.completedLines = [.youngYang, .youngYin]
        sut.startReading()
        XCTAssertTrue(sut.completedLines.isEmpty)
    }

    func testStartReading_resetsCoinsToAllFalse() {
        sut.currentCoins = [true, true, false]
        sut.startReading()
        XCTAssertEqual(sut.currentCoins, [false, false, false])
    }

    func testStartReading_setsCanProceedToFalse() {
        sut.canProceed = true
        sut.startReading()
        XCTAssertFalse(sut.canProceed)
    }

    func testStartReading_setsHasFlippedToFalse() {
        sut.hasFlipped = true
        sut.startReading()
        XCTAssertFalse(sut.hasFlipped)
    }

    // MARK: - 3. proceedToNextLine() Progression

    func testProceedToNextLine_appendsLineValueFromCoins() {
        sut.startReading()
        // 2 heads = youngYin (raw 8)
        sut.currentCoins = [true, true, false]
        sut.proceedToNextLine()
        XCTAssertEqual(sut.completedLines.count, 1)
        XCTAssertEqual(sut.completedLines.first, .youngYin)
    }

    func testProceedToNextLine_incrementsCurrentLine() {
        sut.startReading()
        sut.currentCoins = [true, false, false]
        sut.proceedToNextLine()
        XCTAssertEqual(sut.currentLine, 2)
    }

    func testProceedToNextLine_resetsCoinsAfterAdvancing() {
        sut.startReading()
        sut.currentCoins = [true, true, true]
        sut.proceedToNextLine()
        XCTAssertEqual(sut.currentCoins, [false, false, false])
    }

    func testProceedToNextLine_resetsCanProceedAfterAdvancing() {
        sut.startReading()
        sut.canProceed = true
        sut.currentCoins = [false, false, false]
        sut.proceedToNextLine()
        XCTAssertFalse(sut.canProceed)
    }

    func testProceedToNextLine_resetsHasFlippedAfterAdvancing() {
        sut.startReading()
        sut.hasFlipped = true
        sut.currentCoins = [false, true, false]
        sut.proceedToNextLine()
        XCTAssertFalse(sut.hasFlipped)
    }

    func testProceedToNextLine_progressesThroughAllSixLines() {
        sut.startReading()
        let coinConfigs: [[Bool]] = [
            [false, false, false], // 0 heads -> oldYin
            [true, false, false],  // 1 head  -> youngYang
            [true, true, false],   // 2 heads -> youngYin
            [true, true, true],    // 3 heads -> oldYang
            [false, true, false],  // 1 head  -> youngYang
            [true, true, false],   // 2 heads -> youngYin
        ]

        for (i, coins) in coinConfigs.enumerated() {
            sut.currentCoins = coins
            sut.proceedToNextLine()

            if i < 5 {
                XCTAssertEqual(sut.currentLine, i + 2, "After line \(i + 1), currentLine should be \(i + 2)")
            }
        }

        XCTAssertEqual(sut.completedLines.count, 6)
        XCTAssertEqual(sut.completedLines[0], .oldYin)
        XCTAssertEqual(sut.completedLines[1], .youngYang)
        XCTAssertEqual(sut.completedLines[2], .youngYin)
        XCTAssertEqual(sut.completedLines[3], .oldYang)
        XCTAssertEqual(sut.completedLines[4], .youngYang)
        XCTAssertEqual(sut.completedLines[5], .youngYin)
    }

    // MARK: - 4. proceedToNextLine() Completing on Line 6

    func testProceedToNextLine_setsStateToCompleteOnSixthLine() {
        sut.startReading()
        for _ in 0..<5 {
            sut.currentCoins = [true, false, false]
            sut.proceedToNextLine()
        }
        XCTAssertEqual(sut.state, .flipping, "Should still be flipping before the 6th line")

        sut.currentCoins = [true, false, false]
        sut.proceedToNextLine()
        XCTAssertEqual(sut.state, .complete)
        XCTAssertEqual(sut.completedLines.count, 6)
    }

    func testProceedToNextLine_doesNotResetCoinsOnSixthLine() {
        sut.startReading()
        for _ in 0..<5 {
            sut.currentCoins = [true, true, true]
            sut.proceedToNextLine()
        }
        // On the 6th line, state goes to .complete without resetting coins
        sut.currentCoins = [true, true, true]
        sut.proceedToNextLine()
        // currentLine remains 6 (not incremented past 6)
        XCTAssertEqual(sut.currentLine, 6)
        XCTAssertEqual(sut.state, .complete)
    }

    // MARK: - 5. setManualLines()

    func testSetManualLines_setsCompletedLines() {
        let lines: [LineValue] = [.youngYang, .youngYin, .oldYang, .oldYin, .youngYang, .youngYin]
        sut.setManualLines(lines)
        XCTAssertEqual(sut.completedLines, lines)
    }

    func testSetManualLines_setsStateToComplete() {
        let lines: [LineValue] = [.youngYang, .youngYin, .youngYang, .youngYin, .youngYang, .youngYin]
        sut.setManualLines(lines)
        XCTAssertEqual(sut.state, .complete)
    }

    func testSetManualLines_worksFromIdleState() {
        XCTAssertEqual(sut.state, .idle)
        let lines: [LineValue] = [.youngYang, .youngYang, .youngYang, .youngYang, .youngYang, .youngYang]
        sut.setManualLines(lines)
        XCTAssertEqual(sut.state, .complete)
        XCTAssertEqual(sut.completedLines.count, 6)
    }

    // MARK: - 6. reset()

    func testReset_setsStateToIdle() {
        sut.startReading()
        sut.reset()
        XCTAssertEqual(sut.state, .idle)
    }

    func testReset_clearsQuestion() {
        sut.question = "What lies ahead?"
        sut.reset()
        XCTAssertEqual(sut.question, "")
    }

    func testReset_resetsCurrentLineToOne() {
        sut.startReading()
        sut.currentCoins = [true, false, false]
        sut.proceedToNextLine()
        sut.reset()
        XCTAssertEqual(sut.currentLine, 1)
    }

    func testReset_clearsCompletedLines() {
        sut.setManualLines([.youngYang, .youngYin, .youngYang, .youngYin, .youngYang, .youngYin])
        sut.reset()
        XCTAssertTrue(sut.completedLines.isEmpty)
    }

    func testReset_resetsCoins() {
        sut.currentCoins = [true, true, true]
        sut.reset()
        XCTAssertEqual(sut.currentCoins, [false, false, false])
    }

    func testReset_resetsCanProceed() {
        sut.canProceed = true
        sut.reset()
        XCTAssertFalse(sut.canProceed)
    }

    func testReset_resetsIsFlipping() {
        sut.isFlipping = true
        sut.reset()
        XCTAssertFalse(sut.isFlipping)
    }

    func testReset_resetsHasFlipped() {
        sut.hasFlipped = true
        sut.reset()
        XCTAssertFalse(sut.hasFlipped)
    }

    func testReset_afterCompleteReading_returnsToIdleState() {
        sut.setManualLines([.oldYang, .oldYin, .youngYang, .youngYin, .oldYang, .oldYin])
        XCTAssertEqual(sut.state, .complete)
        sut.reset()
        XCTAssertEqual(sut.state, .idle)
        XCTAssertTrue(sut.completedLines.isEmpty)
        XCTAssertNil(sut.primaryHexagram)
    }

    // MARK: - 7. flipCoins() Guard When Already Flipping

    func testFlipCoins_setsIsFlippingToTrue() {
        sut.startReading()
        sut.flipCoins()
        XCTAssertTrue(sut.isFlipping)
    }

    func testFlipCoins_doesNothingIfAlreadyFlipping() {
        sut.startReading()
        sut.isFlipping = true
        // Should early-return without error
        sut.flipCoins()
        XCTAssertTrue(sut.isFlipping)
    }

    // MARK: - 8. changingLinePositions Computation

    func testChangingLinePositions_noChangingLines_returnsEmpty() {
        sut.setManualLines([.youngYang, .youngYin, .youngYang, .youngYin, .youngYang, .youngYin])
        XCTAssertTrue(sut.changingLinePositions.isEmpty)
    }

    func testChangingLinePositions_allChangingLines() {
        sut.setManualLines([.oldYang, .oldYin, .oldYang, .oldYin, .oldYang, .oldYin])
        XCTAssertEqual(sut.changingLinePositions, Set([1, 2, 3, 4, 5, 6]))
    }

    func testChangingLinePositions_mixedLines() {
        // Positions 1 and 4 are changing (oldYang and oldYin respectively)
        sut.setManualLines([.oldYang, .youngYin, .youngYang, .oldYin, .youngYang, .youngYin])
        XCTAssertEqual(sut.changingLinePositions, Set([1, 4]))
    }

    func testChangingLinePositions_singleChangingLine() {
        sut.setManualLines([.youngYang, .youngYin, .oldYang, .youngYin, .youngYang, .youngYin])
        XCTAssertEqual(sut.changingLinePositions, Set([3]))
    }

    func testChangingLinePositions_incompleteLinesReturnsPartial() {
        sut.completedLines = [.oldYang, .youngYin, .oldYin]
        XCTAssertEqual(sut.changingLinePositions, Set([1, 3]))
    }

    // MARK: - 9. primaryHexagram / relatingHexagram

    func testPrimaryHexagram_withSixLines_returnsHexagram() {
        // All youngYang (solid, non-changing) = Hexagram 1 (Ch'ien / The Creative)
        sut.setManualLines([.youngYang, .youngYang, .youngYang, .youngYang, .youngYang, .youngYang])
        XCTAssertNotNil(sut.primaryHexagram)
    }

    func testPrimaryHexagram_withFewerThanSixLines_returnsNil() {
        sut.completedLines = [.youngYang, .youngYin, .youngYang]
        XCTAssertNil(sut.primaryHexagram)
    }

    func testRelatingHexagram_noChangingLines_returnsNil() {
        sut.setManualLines([.youngYang, .youngYin, .youngYang, .youngYin, .youngYang, .youngYin])
        XCTAssertNil(sut.relatingHexagram)
    }

    func testRelatingHexagram_withChangingLines_returnsHexagram() {
        // Include at least one changing line so relating hexagram is produced
        sut.setManualLines([.oldYang, .youngYin, .youngYang, .youngYin, .youngYang, .youngYin])
        XCTAssertNotNil(sut.primaryHexagram)
        XCTAssertNotNil(sut.relatingHexagram)
    }

    func testRelatingHexagram_differsFromPrimary_whenChangingLinesPresent() {
        sut.setManualLines([.oldYang, .youngYin, .youngYang, .youngYin, .youngYang, .youngYin])
        if let primary = sut.primaryHexagram, let relating = sut.relatingHexagram {
            XCTAssertNotEqual(primary.id, relating.id, "Relating hexagram should differ from primary when changing lines exist")
        } else {
            XCTFail("Both primary and relating hexagrams should be non-nil")
        }
    }

    func testHexagramResults_emptyLines_returnsNil() {
        XCTAssertNil(sut.primaryHexagram)
        XCTAssertNil(sut.relatingHexagram)
    }

    // MARK: - 10. hasFlipped State Management

    func testHasFlipped_initiallyFalse() {
        XCTAssertFalse(sut.hasFlipped)
    }

    func testHasFlipped_remainsFalseAfterStartReading() {
        sut.startReading()
        XCTAssertFalse(sut.hasFlipped)
    }

    func testHasFlipped_resetToFalseOnProceedToNextLine() {
        sut.startReading()
        sut.hasFlipped = true
        sut.currentCoins = [true, false, false]
        sut.proceedToNextLine()
        // After advancing to next line, hasFlipped should be reset
        XCTAssertFalse(sut.hasFlipped)
    }

    func testHasFlipped_resetOnFullReset() {
        sut.hasFlipped = true
        sut.reset()
        XCTAssertFalse(sut.hasFlipped)
    }

    // MARK: - LineValue.from(heads:) Mapping (integration with proceedToNextLine)

    func testProceedToNextLine_zeroHeads_appendsOldYin() {
        sut.startReading()
        sut.currentCoins = [false, false, false]
        sut.proceedToNextLine()
        XCTAssertEqual(sut.completedLines.last, .oldYin)
    }

    func testProceedToNextLine_oneHead_appendsYoungYang() {
        sut.startReading()
        sut.currentCoins = [true, false, false]
        sut.proceedToNextLine()
        XCTAssertEqual(sut.completedLines.last, .youngYang)
    }

    func testProceedToNextLine_twoHeads_appendsYoungYin() {
        sut.startReading()
        sut.currentCoins = [true, true, false]
        sut.proceedToNextLine()
        XCTAssertEqual(sut.completedLines.last, .youngYin)
    }

    func testProceedToNextLine_threeHeads_appendsOldYang() {
        sut.startReading()
        sut.currentCoins = [true, true, true]
        sut.proceedToNextLine()
        XCTAssertEqual(sut.completedLines.last, .oldYang)
    }

    // MARK: - State Transition Sequences

    func testFullReadingFlow_idleToFlippingToComplete() {
        XCTAssertEqual(sut.state, .idle)
        sut.startReading()
        XCTAssertEqual(sut.state, .flipping)

        for _ in 0..<6 {
            sut.currentCoins = [true, false, false]
            sut.proceedToNextLine()
        }
        XCTAssertEqual(sut.state, .complete)
    }

    func testFullReadingFlow_resetAndStartAgain() {
        sut.startReading()
        for _ in 0..<6 {
            sut.currentCoins = [false, true, false]
            sut.proceedToNextLine()
        }
        XCTAssertEqual(sut.state, .complete)

        sut.reset()
        XCTAssertEqual(sut.state, .idle)

        sut.startReading()
        XCTAssertEqual(sut.state, .flipping)
        XCTAssertTrue(sut.completedLines.isEmpty)
        XCTAssertEqual(sut.currentLine, 1)
    }
}
