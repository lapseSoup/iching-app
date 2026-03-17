import XCTest
@testable import IChing

final class HexagramTests: XCTestCase {

    // MARK: - Hexagram.from(lineValues:)

    func testFromLineValues_allYoungYang_returnsCreative() {
        let lines: [LineValue] = [.youngYang, .youngYang, .youngYang, .youngYang, .youngYang, .youngYang]
        let result = Hexagram.from(lineValues: lines)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.primary.id, 1)
        XCTAssertNil(result?.relating) // No changing lines
    }

    func testFromLineValues_allYoungYin_returnsReceptive() {
        let lines: [LineValue] = [.youngYin, .youngYin, .youngYin, .youngYin, .youngYin, .youngYin]
        let result = Hexagram.from(lineValues: lines)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.primary.id, 2)
        XCTAssertNil(result?.relating)
    }

    func testFromLineValues_withChangingLines_producesRelating() {
        // All old yang (9) → transforms to all yin = The Receptive
        let lines: [LineValue] = [.oldYang, .oldYang, .oldYang, .oldYang, .oldYang, .oldYang]
        let result = Hexagram.from(lineValues: lines)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.primary.id, 1) // The Creative
        XCTAssertNotNil(result?.relating)
        XCTAssertEqual(result?.relating?.id, 2) // The Receptive
    }

    func testFromLineValues_wrongCount_returnsNil() {
        let lines: [LineValue] = [.youngYang, .youngYang]
        XCTAssertNil(Hexagram.from(lineValues: lines))
    }

    func testFromLineValues_emptyArray_returnsNil() {
        XCTAssertNil(Hexagram.from(lineValues: []))
    }

    // MARK: - Transformation

    func testTransformed_noChangingLines_returnsNil() {
        let hex = HexagramLibrary.shared.hexagram(number: 1)!
        XCTAssertNil(hex.transformed(withChangingLines: []))
    }

    func testTransformed_singleLine_producesNewHexagram() {
        let creative = HexagramLibrary.shared.hexagram(number: 1)!
        // Flipping line 1 of all-yang: [false, true, true, true, true, true]
        let result = creative.transformed(withChangingLines: [1])
        XCTAssertNotNil(result)
        XCTAssertNotEqual(result?.id, 1) // Should be different from Creative
    }

    func testTransformed_invalidPosition_ignored() {
        let hex = HexagramLibrary.shared.hexagram(number: 1)!
        // Position 0 and 7 are invalid, should be ignored
        let result = hex.transformed(withChangingLines: [0, 7])
        XCTAssertNil(result) // No valid positions → no transformation
    }

    // MARK: - Hashable

    func testHashable_sameId_sameHash() {
        let hex1 = HexagramLibrary.shared.hexagram(number: 1)!
        let hex2 = HexagramLibrary.shared.hexagram(number: 1)!
        XCTAssertEqual(hex1.hashValue, hex2.hashValue)
    }

    func testHashable_differentId_typicallyDifferentHash() {
        let hex1 = HexagramLibrary.shared.hexagram(number: 1)!
        let hex2 = HexagramLibrary.shared.hexagram(number: 2)!
        // Hash collision is possible but extremely unlikely for small ints
        XCTAssertNotEqual(hex1.hashValue, hex2.hashValue)
    }

    func testHashable_canBeUsedInSet() {
        let hex1 = HexagramLibrary.shared.hexagram(number: 1)!
        let hex2 = HexagramLibrary.shared.hexagram(number: 2)!
        let hex1Dup = HexagramLibrary.shared.hexagram(number: 1)!

        var set: Set<Hexagram> = [hex1, hex2, hex1Dup]
        XCTAssertEqual(set.count, 2) // Duplicate removed
    }
}
