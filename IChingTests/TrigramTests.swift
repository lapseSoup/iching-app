import XCTest
@testable import IChing

final class TrigramTests: XCTestCase {

    // MARK: - from(lines:) — All 8 Trigrams

    func testFromLines_heaven() {
        XCTAssertEqual(Trigram.from(lines: [true, true, true]), .heaven)
    }

    func testFromLines_lake() {
        XCTAssertEqual(Trigram.from(lines: [true, true, false]), .lake)
    }

    func testFromLines_fire() {
        XCTAssertEqual(Trigram.from(lines: [true, false, true]), .fire)
    }

    func testFromLines_thunder() {
        XCTAssertEqual(Trigram.from(lines: [true, false, false]), .thunder)
    }

    func testFromLines_wind() {
        XCTAssertEqual(Trigram.from(lines: [false, true, true]), .wind)
    }

    func testFromLines_water() {
        XCTAssertEqual(Trigram.from(lines: [false, true, false]), .water)
    }

    func testFromLines_mountain() {
        XCTAssertEqual(Trigram.from(lines: [false, false, true]), .mountain)
    }

    func testFromLines_earth() {
        XCTAssertEqual(Trigram.from(lines: [false, false, false]), .earth)
    }

    // MARK: - from(lines:) — Invalid Input

    func testFromLines_tooFew_returnsNil() {
        XCTAssertNil(Trigram.from(lines: [true, false]))
    }

    func testFromLines_tooMany_returnsNil() {
        XCTAssertNil(Trigram.from(lines: [true, false, true, false]))
    }

    func testFromLines_empty_returnsNil() {
        XCTAssertNil(Trigram.from(lines: []))
    }

    // MARK: - from(name:) — All 8 Trigrams

    func testFromName_heaven() {
        XCTAssertEqual(Trigram.from(name: "heaven"), .heaven)
    }

    func testFromName_lake() {
        XCTAssertEqual(Trigram.from(name: "lake"), .lake)
    }

    func testFromName_fire() {
        XCTAssertEqual(Trigram.from(name: "fire"), .fire)
    }

    func testFromName_thunder() {
        XCTAssertEqual(Trigram.from(name: "thunder"), .thunder)
    }

    func testFromName_wind() {
        XCTAssertEqual(Trigram.from(name: "wind"), .wind)
    }

    func testFromName_water() {
        XCTAssertEqual(Trigram.from(name: "water"), .water)
    }

    func testFromName_mountain() {
        XCTAssertEqual(Trigram.from(name: "mountain"), .mountain)
    }

    func testFromName_earth() {
        XCTAssertEqual(Trigram.from(name: "earth"), .earth)
    }

    // MARK: - from(name:) — Invalid Input

    func testFromName_invalid_returnsNil() {
        XCTAssertNil(Trigram.from(name: "void"))
    }

    func testFromName_emptyString_returnsNil() {
        XCTAssertNil(Trigram.from(name: ""))
    }

    func testFromName_capitalized_returnsNil() {
        XCTAssertNil(Trigram.from(name: "Heaven"))
    }

    // MARK: - Distinct Lines

    func testAllTrigramsHaveDistinctLines() {
        var seen = Set<String>()
        for trigram in Trigram.allCases {
            let key = trigram.lines.map { $0 ? "1" : "0" }.joined()
            let inserted = seen.insert(key).inserted
            XCTAssertTrue(inserted, "Trigram \(trigram) has duplicate lines: \(key)")
        }
        XCTAssertEqual(seen.count, 8)
    }

    // MARK: - Non-Empty Properties

    func testAllTrigramsHaveNonEmptySymbol() {
        for trigram in Trigram.allCases {
            XCTAssertFalse(trigram.symbol.isEmpty, "\(trigram) has empty symbol")
        }
    }

    func testAllTrigramsHaveNonEmptyChineseName() {
        for trigram in Trigram.allCases {
            XCTAssertFalse(trigram.chineseName.isEmpty, "\(trigram) has empty chineseName")
        }
    }

    func testAllTrigramsHaveNonEmptyEnglishName() {
        for trigram in Trigram.allCases {
            XCTAssertFalse(trigram.englishName.isEmpty, "\(trigram) has empty englishName")
        }
    }

    func testAllTrigramsHaveNonEmptyElement() {
        for trigram in Trigram.allCases {
            XCTAssertFalse(trigram.element.isEmpty, "\(trigram) has empty element")
        }
    }
}
