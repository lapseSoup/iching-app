import XCTest
@testable import IChing

final class LineValueTests: XCTestCase {

    // MARK: - Coin Flip Mapping (regression test for B-1)

    func testFromHeads_zeroHeads_returnsOldYin() {
        XCTAssertEqual(LineValue.from(heads: 0), .oldYin)
        XCTAssertEqual(LineValue.from(heads: 0).rawValue, 6)
    }

    func testFromHeads_oneHead_returnsYoungYang() {
        XCTAssertEqual(LineValue.from(heads: 1), .youngYang)
        XCTAssertEqual(LineValue.from(heads: 1).rawValue, 7)
    }

    func testFromHeads_twoHeads_returnsYoungYin() {
        XCTAssertEqual(LineValue.from(heads: 2), .youngYin)
        XCTAssertEqual(LineValue.from(heads: 2).rawValue, 8)
    }

    func testFromHeads_threeHeads_returnsOldYang() {
        XCTAssertEqual(LineValue.from(heads: 3), .oldYang)
        XCTAssertEqual(LineValue.from(heads: 3).rawValue, 9)
    }

    // B-58: `LineValue.from(heads:)` now traps on out-of-range input via precondition.
    // The previous silent-fallback contract was a latent corruption risk. There's no
    // straightforward XCTest hook to verify a precondition trap without subprocessing,
    // so we document the new contract by enumerating valid inputs instead.
    func testFromHeads_validRange_coversAllLineValues() {
        let mapping: [Int: LineValue] = [0: .oldYin, 1: .youngYang, 2: .youngYin, 3: .oldYang]
        for (heads, expected) in mapping {
            XCTAssertEqual(LineValue.from(heads: heads), expected, "heads=\(heads) should map to \(expected)")
        }
    }

    // MARK: - Line Properties

    func testIsYang() {
        XCTAssertFalse(LineValue.oldYin.isYang)
        XCTAssertTrue(LineValue.youngYang.isYang)
        XCTAssertFalse(LineValue.youngYin.isYang)
        XCTAssertTrue(LineValue.oldYang.isYang)
    }

    func testIsChanging() {
        XCTAssertTrue(LineValue.oldYin.isChanging)
        XCTAssertFalse(LineValue.youngYang.isChanging)
        XCTAssertFalse(LineValue.youngYin.isChanging)
        XCTAssertTrue(LineValue.oldYang.isChanging)
    }

    func testChangingSymbol() {
        XCTAssertEqual(LineValue.oldYang.changingSymbol, "○")
        XCTAssertEqual(LineValue.oldYin.changingSymbol, "×")
        XCTAssertNil(LineValue.youngYang.changingSymbol)
        XCTAssertNil(LineValue.youngYin.changingSymbol)
    }

    // MARK: - Raw Value Round-Trip

    func testRawValueRoundTrip() {
        for value in LineValue.allCases {
            XCTAssertEqual(LineValue(rawValue: value.rawValue), value)
        }
    }

    func testInvalidRawValue_returnsNil() {
        XCTAssertNil(LineValue(rawValue: 0))
        XCTAssertNil(LineValue(rawValue: 5))
        XCTAssertNil(LineValue(rawValue: 10))
    }
}
