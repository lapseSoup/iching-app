import XCTest
@testable import IChing

final class HexagramBasicDataTests: XCTestCase {

    // MARK: - JSON Loading

    func testAllHexagramsPresent() {
        XCTAssertEqual(HexagramBasicInfo.all.count, 64,
                       "hexagram_basic.json should contain exactly 64 hexagrams")
    }

    func testIdsAre1Through64() {
        let ids = HexagramBasicInfo.all.map(\.id).sorted()
        XCTAssertEqual(ids, Array(1...64))
    }

    func testAllHaveNonEmptyNames() {
        for hex in HexagramBasicInfo.all {
            XCTAssertFalse(hex.englishName.isEmpty, "Hexagram \(hex.id) has empty name")
            XCTAssertFalse(hex.chineseName.isEmpty, "Hexagram \(hex.id) has empty Chinese name")
            XCTAssertFalse(hex.character.isEmpty, "Hexagram \(hex.id) has empty character")
        }
    }

    func testAllHave6Lines() {
        for hex in HexagramBasicInfo.all {
            XCTAssertEqual(hex.lines.count, 6, "Hexagram \(hex.id) should have 6 lines")
        }
    }

    // MARK: - Cross-Source Consistency

    /// Validates that hexagram_basic.json stays consistent with the richer hexagrams.json
    /// used by HexagramLibrary. Both files must agree on names, characters, and line patterns.
    func testBasicDataMatchesLibrary() {
        for basic in HexagramBasicInfo.all {
            guard let full = HexagramLibrary.shared.hexagram(number: basic.id) else {
                XCTFail("HexagramLibrary missing hexagram \(basic.id)")
                continue
            }
            XCTAssertEqual(basic.englishName, full.englishName, "Name mismatch for hexagram \(basic.id)")
            XCTAssertEqual(basic.chineseName, full.chineseName, "Chinese name mismatch for hexagram \(basic.id)")
            XCTAssertEqual(basic.character, full.character, "Character mismatch for hexagram \(basic.id)")
            XCTAssertEqual(basic.lines, full.lines, "Lines mismatch for hexagram \(basic.id)")
        }
    }

    // MARK: - Daily Hexagram Seeding

    func testDailyHexagramId_returnsValidRange() {
        let date = Date()
        let id = HexagramBasicInfo.dailyHexagramId(for: date)
        XCTAssertGreaterThanOrEqual(id, 1)
        XCTAssertLessThanOrEqual(id, 64)
    }

    func testDailyHexagramId_sameDay_sameResult() {
        let date = Date()
        let id1 = HexagramBasicInfo.dailyHexagramId(for: date)
        let id2 = HexagramBasicInfo.dailyHexagramId(for: date)
        XCTAssertEqual(id1, id2)
    }

    func testDailyHexagramId_differentDays_typicallyDifferent() {
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let todayId = HexagramBasicInfo.dailyHexagramId(for: today)
        let tomorrowId = HexagramBasicInfo.dailyHexagramId(for: tomorrow)
        // They should differ (unless we hit the 1/64 chance they wrap to same)
        // We test the mechanism works, not the specific values
        XCTAssertNotEqual(todayId, tomorrowId)
    }
}
