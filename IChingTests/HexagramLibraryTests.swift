import XCTest
@testable import IChing

final class HexagramLibraryTests: XCTestCase {

    // MARK: - Library Loading

    func testLibraryLoads64Hexagrams() {
        let library = HexagramLibrary.shared
        XCTAssertEqual(library.hexagrams.count, 64)
    }

    func testAllHexagramsHaveUniqueIds() {
        let library = HexagramLibrary.shared
        let ids = Set(library.hexagrams.map(\.id))
        XCTAssertEqual(ids.count, 64)
    }

    func testAllHexagramIdsAre1Through64() {
        let library = HexagramLibrary.shared
        let ids = library.hexagrams.map(\.id).sorted()
        XCTAssertEqual(ids, Array(1...64))
    }

    // MARK: - Lookup by Number

    func testHexagramByNumber_valid() {
        let hex = HexagramLibrary.shared.hexagram(number: 1)
        XCTAssertNotNil(hex)
        XCTAssertEqual(hex?.id, 1)
        XCTAssertEqual(hex?.englishName, "The Creative")
    }

    func testHexagramByNumber_lastHexagram() {
        let hex = HexagramLibrary.shared.hexagram(number: 64)
        XCTAssertNotNil(hex)
        XCTAssertEqual(hex?.id, 64)
    }

    func testHexagramByNumber_invalidZero_returnsNil() {
        XCTAssertNil(HexagramLibrary.shared.hexagram(number: 0))
    }

    func testHexagramByNumber_invalidNegative_returnsNil() {
        XCTAssertNil(HexagramLibrary.shared.hexagram(number: -1))
    }

    func testHexagramByNumber_invalid65_returnsNil() {
        XCTAssertNil(HexagramLibrary.shared.hexagram(number: 65))
    }

    // MARK: - Lookup by Lines

    func testHexagramByLines_allYang_isCreative() {
        let hex = HexagramLibrary.shared.hexagram(forLines: [true, true, true, true, true, true])
        XCTAssertNotNil(hex)
        XCTAssertEqual(hex?.id, 1) // The Creative
    }

    func testHexagramByLines_allYin_isReceptive() {
        let hex = HexagramLibrary.shared.hexagram(forLines: [false, false, false, false, false, false])
        XCTAssertNotNil(hex)
        XCTAssertEqual(hex?.id, 2) // The Receptive
    }

    func testHexagramByLines_wrongCount_returnsNil() {
        XCTAssertNil(HexagramLibrary.shared.hexagram(forLines: [true, true, true]))
        XCTAssertNil(HexagramLibrary.shared.hexagram(forLines: []))
    }

    // MARK: - All 64 Hexagrams Have Required Data

    func testAllHexagramsHaveNonEmptyNames() {
        for hex in HexagramLibrary.shared.hexagrams {
            XCTAssertFalse(hex.englishName.isEmpty, "Hexagram \(hex.id) has empty English name")
            XCTAssertFalse(hex.chineseName.isEmpty, "Hexagram \(hex.id) has empty Chinese name")
            XCTAssertFalse(hex.pinyin.isEmpty, "Hexagram \(hex.id) has empty pinyin")
        }
    }

    func testAllHexagramsHave6LineTexts() {
        for hex in HexagramLibrary.shared.hexagrams {
            XCTAssertEqual(hex.lineTexts.count, 6, "Hexagram \(hex.id) should have 6 line texts")
        }
    }

    func testAllHexagramsHaveValidTrigrams() {
        for hex in HexagramLibrary.shared.hexagrams {
            XCTAssertEqual(hex.upperTrigram.lines.count, 3, "Hexagram \(hex.id) upper trigram should have 3 lines")
            XCTAssertEqual(hex.lowerTrigram.lines.count, 3, "Hexagram \(hex.id) lower trigram should have 3 lines")
        }
    }

    func testAllHexagramsHaveUniqueLinePatterns() {
        let library = HexagramLibrary.shared
        var patterns = Set<String>()
        for hex in library.hexagrams {
            let pattern = hex.lines.map { $0 ? "1" : "0" }.joined()
            let inserted = patterns.insert(pattern).inserted
            XCTAssertTrue(inserted, "Hexagram \(hex.id) has duplicate line pattern: \(pattern)")
        }
        XCTAssertEqual(patterns.count, 64)
    }
}
