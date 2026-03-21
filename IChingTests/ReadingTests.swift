import XCTest
@testable import IChing

final class ReadingTests: XCTestCase {

    // MARK: - Helpers

    /// All young yang lines (no changing) — produces hexagram 1 (The Creative)
    private var allYoungYang: [LineValue] {
        Array(repeating: LineValue.youngYang, count: 6)
    }

    /// All young yin lines (no changing) — produces hexagram 2 (The Receptive)
    private var allYoungYin: [LineValue] {
        Array(repeating: LineValue.youngYin, count: 6)
    }

    /// Mixed lines with changing lines at positions 1, 3, 5 (old yang/old yin)
    private var mixedWithChanging: [LineValue] {
        [.oldYin, .youngYang, .oldYang, .youngYin, .oldYin, .youngYang]
    }

    /// Lines with a single changing line at position 1
    private var singleChanging: [LineValue] {
        [.oldYang, .youngYang, .youngYang, .youngYang, .youngYang, .youngYang]
    }

    // MARK: - 1. Initialization with valid lines

    func testInitWithValidLines_setsProperties() {
        let reading = Reading(question: "Will it rain?", lines: allYoungYang, method: .coinFlip, isDailyReading: false)

        XCTAssertEqual(reading.question, "Will it rain?")
        XCTAssertEqual(reading.method, .coinFlip)
        XCTAssertFalse(reading.isDailyReading)
        XCTAssertEqual(reading.notes, "")
        XCTAssertTrue(reading.journalEntries.isEmpty)
        XCTAssertNotNil(reading.id)
        XCTAssertNotNil(reading.createdAt)
    }

    func testInitWithDefaultParameters() {
        let reading = Reading(lines: allYoungYin)

        XCTAssertEqual(reading.question, "")
        XCTAssertEqual(reading.method, .coinFlip)
        XCTAssertFalse(reading.isDailyReading)
    }

    func testInitStoresLineValuesRaw() {
        let lines: [LineValue] = [.oldYin, .youngYang, .youngYin, .oldYang, .youngYin, .youngYang]
        let reading = Reading(lines: lines)

        XCTAssertEqual(reading.lineValuesRaw, [6, 7, 8, 9, 8, 7])
    }

    func testInitWithDailyReading() {
        let reading = Reading(lines: allYoungYang, method: .random, isDailyReading: true)

        XCTAssertTrue(reading.isDailyReading)
        XCTAssertEqual(reading.method, .random)
    }

    func testInitWithYarrowStalks() {
        let reading = Reading(lines: allYoungYin, method: .yarrowStalks)

        XCTAssertEqual(reading.method, .yarrowStalks)
    }

    // MARK: - 2. lineValues reconstruction from lineValuesRaw

    func testLineValuesReconstructsFromRaw() {
        let original: [LineValue] = [.oldYin, .youngYang, .youngYin, .oldYang, .youngYin, .youngYang]
        let reading = Reading(lines: original)

        let reconstructed = reading.lineValues
        XCTAssertEqual(reconstructed, original)
    }

    func testLineValuesRoundTripsAllCases() {
        // Use all four line value types
        let lines: [LineValue] = [.oldYin, .youngYang, .youngYin, .oldYang, .youngYin, .oldYin]
        let reading = Reading(lines: lines)

        XCTAssertEqual(reading.lineValues.count, 6)
        XCTAssertEqual(reading.lineValues[0], .oldYin)
        XCTAssertEqual(reading.lineValues[1], .youngYang)
        XCTAssertEqual(reading.lineValues[2], .youngYin)
        XCTAssertEqual(reading.lineValues[3], .oldYang)
        XCTAssertEqual(reading.lineValues[4], .youngYin)
        XCTAssertEqual(reading.lineValues[5], .oldYin)
    }

    // MARK: - 3. Reading.create() success path

    func testCreateSucceedsWithValidLines() {
        let result = Reading.create(question: "Test?", lines: allYoungYang)

        switch result {
        case .success(let reading):
            XCTAssertEqual(reading.question, "Test?")
            XCTAssertEqual(reading.lineValuesRaw.count, 6)
        case .failure(let error):
            XCTFail("Expected success, got error: \(error)")
        }
    }

    func testCreateSucceedsWithChangingLines() {
        let result = Reading.create(lines: mixedWithChanging, method: .yarrowStalks)

        switch result {
        case .success(let reading):
            XCTAssertEqual(reading.method, .yarrowStalks)
            XCTAssertTrue(reading.hasChangingLines)
        case .failure(let error):
            XCTFail("Expected success, got error: \(error)")
        }
    }

    func testCreateSucceedsWithDailyReading() {
        let result = Reading.create(lines: allYoungYin, method: .random, isDailyReading: true)

        switch result {
        case .success(let reading):
            XCTAssertTrue(reading.isDailyReading)
        case .failure(let error):
            XCTFail("Expected success, got error: \(error)")
        }
    }

    // MARK: - 4. Reading.create() failure with wrong line count

    func testCreateFailsWithTooFewLines() {
        let result = Reading.create(lines: [.youngYang, .youngYin])

        switch result {
        case .success:
            XCTFail("Expected failure for too few lines")
        case .failure(let error):
            if case .invalidLineCount(let expected, let actual) = error {
                XCTAssertEqual(expected, 6)
                XCTAssertEqual(actual, 2)
            } else {
                XCTFail("Expected invalidLineCount, got \(error)")
            }
        }
    }

    func testCreateFailsWithTooManyLines() {
        let lines = Array(repeating: LineValue.youngYang, count: 7)
        let result = Reading.create(lines: lines)

        switch result {
        case .success:
            XCTFail("Expected failure for too many lines")
        case .failure(let error):
            if case .invalidLineCount(let expected, let actual) = error {
                XCTAssertEqual(expected, 6)
                XCTAssertEqual(actual, 7)
            } else {
                XCTFail("Expected invalidLineCount, got \(error)")
            }
        }
    }

    func testCreateFailsWithEmptyLines() {
        let result = Reading.create(lines: [])

        switch result {
        case .success:
            XCTFail("Expected failure for empty lines")
        case .failure(let error):
            if case .invalidLineCount(let expected, let actual) = error {
                XCTAssertEqual(expected, 6)
                XCTAssertEqual(actual, 0)
            } else {
                XCTFail("Expected invalidLineCount, got \(error)")
            }
        }
    }

    // MARK: - 5. changingLinePositions with mixed lines

    func testChangingLinePositionsWithMixedLines() {
        // [.oldYin, .youngYang, .oldYang, .youngYin, .oldYin, .youngYang]
        // Changing at positions 1, 3, 5 (1-indexed)
        let reading = Reading(lines: mixedWithChanging)

        let positions = reading.changingLinePositions
        XCTAssertEqual(positions, Set([1, 3, 5]))
    }

    func testChangingLinePositionsWithNoChanging() {
        let reading = Reading(lines: allYoungYang)

        XCTAssertTrue(reading.changingLinePositions.isEmpty)
    }

    func testChangingLinePositionsWithSingleChanging() {
        // oldYang at position 1 only
        let reading = Reading(lines: singleChanging)

        XCTAssertEqual(reading.changingLinePositions, Set([1]))
    }

    func testChangingLinePositionsWithAllChanging() {
        let lines: [LineValue] = [.oldYin, .oldYang, .oldYin, .oldYang, .oldYin, .oldYang]
        let reading = Reading(lines: lines)

        XCTAssertEqual(reading.changingLinePositions, Set([1, 2, 3, 4, 5, 6]))
    }

    // MARK: - 6. hasChangingLines true/false

    func testHasChangingLinesTrue() {
        let reading = Reading(lines: singleChanging)

        XCTAssertTrue(reading.hasChangingLines)
    }

    func testHasChangingLinesFalseAllYoungYang() {
        let reading = Reading(lines: allYoungYang)

        XCTAssertFalse(reading.hasChangingLines)
    }

    func testHasChangingLinesFalseAllYoungYin() {
        let reading = Reading(lines: allYoungYin)

        XCTAssertFalse(reading.hasChangingLines)
    }

    func testHasChangingLinesFalseMixedYoung() {
        let lines: [LineValue] = [.youngYang, .youngYin, .youngYang, .youngYin, .youngYang, .youngYin]
        let reading = Reading(lines: lines)

        XCTAssertFalse(reading.hasChangingLines)
    }

    // MARK: - 7. primaryHexagram caching works

    func testPrimaryHexagramIsNotNil() {
        let reading = Reading(lines: allYoungYang)

        // All young yang = hexagram 1 (The Creative / Qian)
        let hexagram = reading.primaryHexagram
        XCTAssertNotNil(hexagram)
        XCTAssertEqual(hexagram?.id, reading.primaryHexagramId)
    }

    func testPrimaryHexagramReturnsSameInstanceOnRepeatedAccess() {
        let reading = Reading(lines: allYoungYang)

        let first = reading.primaryHexagram
        let second = reading.primaryHexagram

        // Both accesses should return the same hexagram
        XCTAssertNotNil(first)
        XCTAssertNotNil(second)
        XCTAssertEqual(first?.id, second?.id)
    }

    func testPrimaryHexagramIdSetCorrectly() {
        // All young yang produces hexagram 1
        let reading = Reading(lines: allYoungYang)
        XCTAssertEqual(reading.primaryHexagramId, 1)

        // All young yin produces hexagram 2
        let reading2 = Reading(lines: allYoungYin)
        XCTAssertEqual(reading2.primaryHexagramId, 2)
    }

    // MARK: - 8. relatingHexagram nil when no changing lines

    func testRelatingHexagramNilWithNoChangingLines() {
        let reading = Reading(lines: allYoungYang)

        XCTAssertNil(reading.relatingHexagramId)
        XCTAssertNil(reading.relatingHexagram)
    }

    func testRelatingHexagramNilWithAllYoungYin() {
        let reading = Reading(lines: allYoungYin)

        XCTAssertNil(reading.relatingHexagramId)
        XCTAssertNil(reading.relatingHexagram)
    }

    // MARK: - 9. relatingHexagram present with changing lines

    func testRelatingHexagramPresentWithChangingLines() {
        let reading = Reading(lines: singleChanging)

        XCTAssertNotNil(reading.relatingHexagramId)
        XCTAssertNotNil(reading.relatingHexagram)
    }

    func testRelatingHexagramDiffersFromPrimary() {
        let reading = Reading(lines: singleChanging)

        XCTAssertNotNil(reading.primaryHexagram)
        XCTAssertNotNil(reading.relatingHexagram)
        XCTAssertNotEqual(reading.primaryHexagram?.id, reading.relatingHexagram?.id)
    }

    func testRelatingHexagramIdMatchesCachedHexagram() {
        let reading = Reading(lines: mixedWithChanging)

        if let relatingId = reading.relatingHexagramId {
            XCTAssertEqual(reading.relatingHexagram?.id, relatingId)
        } else {
            XCTFail("Expected relatingHexagramId to be non-nil for changing lines")
        }
    }

    // MARK: - 10. formattedDate / shortDate output

    func testFormattedDateIsNotEmpty() {
        let reading = Reading(lines: allYoungYang)

        let formatted = reading.formattedDate
        XCTAssertFalse(formatted.isEmpty, "formattedDate should not be empty")
    }

    func testShortDateIsNotEmpty() {
        let reading = Reading(lines: allYoungYang)

        let shortDate = reading.shortDate
        XCTAssertFalse(shortDate.isEmpty, "shortDate should not be empty")
    }

    func testFormattedDateMatchesExpectedFormat() {
        let reading = Reading(lines: allYoungYang)

        // formattedDate uses longDate (dateStyle .long, timeStyle .short)
        let expected = DateFormatters.longDate.string(from: reading.createdAt)
        XCTAssertEqual(reading.formattedDate, expected)
    }

    func testShortDateMatchesExpectedFormat() {
        let reading = Reading(lines: allYoungYang)

        // shortDate uses shortDate (dateStyle .medium, timeStyle .none)
        let expected = DateFormatters.shortDate.string(from: reading.createdAt)
        XCTAssertEqual(reading.shortDate, expected)
    }

    func testFormattedDateDiffersFromShortDate() {
        let reading = Reading(lines: allYoungYang)

        // Long date includes time, short date does not, so they should differ
        XCTAssertNotEqual(reading.formattedDate, reading.shortDate)
    }

    // MARK: - Lines property

    func testLinesPropertyReturnsCorrectCount() {
        let reading = Reading(lines: allYoungYang)

        XCTAssertEqual(reading.lines.count, 6)
    }

    func testLinesPropertyHasCorrectPositions() {
        let reading = Reading(lines: allYoungYang)

        let positions = reading.lines.map(\.position)
        XCTAssertEqual(positions, [1, 2, 3, 4, 5, 6])
    }

    func testLinesPropertyPreservesValues() {
        let input: [LineValue] = [.oldYin, .youngYang, .youngYin, .oldYang, .youngYin, .youngYang]
        let reading = Reading(lines: input)

        let values = reading.lines.map(\.value)
        XCTAssertEqual(values, input)
    }

    // MARK: - ReadingMethod

    func testAllReadingMethodsAccepted() {
        for method in ReadingMethod.allCases {
            let reading = Reading(lines: allYoungYang, method: method)
            XCTAssertEqual(reading.method, method)
        }
    }
}
