import XCTest
@testable import IChing

final class JournalEntryTests: XCTestCase {

    // MARK: - Initialization

    func testInitWithContentOnly() {
        let entry = JournalEntry(content: "Test reflection")

        XCTAssertEqual(entry.content, "Test reflection")
        XCTAssertNil(entry.mood)
        XCTAssertNil(entry.reading)
        XCTAssertNotNil(entry.id)
    }

    func testInitWithMood() {
        let entry = JournalEntry(content: "Feeling at peace", mood: .peaceful)

        XCTAssertEqual(entry.content, "Feeling at peace")
        XCTAssertEqual(entry.mood, .peaceful)
        XCTAssertNil(entry.reading)
    }

    func testInitSetsCreatedAtAndUpdatedAt() {
        let before = Date()
        let entry = JournalEntry(content: "Timestamped")
        let after = Date()

        XCTAssertGreaterThanOrEqual(entry.createdAt, before)
        XCTAssertLessThanOrEqual(entry.createdAt, after)
        XCTAssertGreaterThanOrEqual(entry.updatedAt, before)
        XCTAssertLessThanOrEqual(entry.updatedAt, after)
    }

    func testInitGeneratesUniqueIDs() {
        let entry1 = JournalEntry(content: "First")
        let entry2 = JournalEntry(content: "Second")

        XCTAssertNotEqual(entry1.id, entry2.id)
    }

    // MARK: - update()

    func testUpdateChangesContentAndMood() {
        let entry = JournalEntry(content: "Original", mood: .curious)

        entry.update(content: "Updated content", mood: .grateful)

        XCTAssertEqual(entry.content, "Updated content")
        XCTAssertEqual(entry.mood, .grateful)
    }

    func testUpdateChangesUpdatedAt() {
        let entry = JournalEntry(content: "Original")
        let originalUpdatedAt = entry.updatedAt

        // Small delay to ensure timestamp differs
        Thread.sleep(forTimeInterval: 0.01)
        entry.update(content: "Changed", mood: nil)

        XCTAssertGreaterThan(entry.updatedAt, originalUpdatedAt)
    }

    func testUpdateDoesNotChangeCreatedAt() {
        let entry = JournalEntry(content: "Original")
        let originalCreatedAt = entry.createdAt

        entry.update(content: "Changed", mood: .hopeful)

        XCTAssertEqual(entry.createdAt, originalCreatedAt)
    }

    func testUpdateCanSetMoodToNil() {
        let entry = JournalEntry(content: "With mood", mood: .anxious)

        entry.update(content: "Without mood", mood: nil)

        XCTAssertNil(entry.mood)
    }

    // MARK: - isEdited

    func testIsEditedFalseWhenJustCreated() {
        let entry = JournalEntry(content: "Fresh entry")

        XCTAssertFalse(entry.isEdited)
    }

    func testIsEditedFalseWhenUpdatedWithin60Seconds() {
        let entry = JournalEntry(content: "Recent")
        // updatedAt is essentially equal to createdAt right after init
        entry.update(content: "Quick edit", mood: nil)

        XCTAssertFalse(entry.isEdited)
    }

    func testIsEditedTrueWhenUpdatedAtMoreThan60SecondsAfterCreatedAt() {
        let entry = JournalEntry(content: "Old entry")
        // Manually set updatedAt to 61 seconds after createdAt
        entry.updatedAt = entry.createdAt.addingTimeInterval(61)

        XCTAssertTrue(entry.isEdited)
    }

    func testIsEditedFalseAtExactly60Seconds() {
        let entry = JournalEntry(content: "Boundary test")
        entry.updatedAt = entry.createdAt.addingTimeInterval(60)

        // Threshold is strictly greater than 60, so exactly 60 should be false
        XCTAssertFalse(entry.isEdited)
    }

    // MARK: - formattedDate

    func testFormattedDateReturnsNonEmptyString() {
        let entry = JournalEntry(content: "Date test")

        let formatted = entry.formattedDate

        XCTAssertFalse(formatted.isEmpty)
    }

    // MARK: - Mood Enum

    func testMoodHasAllEightCases() {
        XCTAssertEqual(Mood.allCases.count, 8)
    }

    func testMoodAllCasesPresent() {
        let expected: Set<Mood> = [
            .peaceful, .hopeful, .curious, .uncertain,
            .anxious, .grateful, .inspired, .reflective
        ]
        XCTAssertEqual(Set(Mood.allCases), expected)
    }

    func testMoodDisplayNameIsCapitalized() {
        for mood in Mood.allCases {
            let displayName = mood.displayName
            XCTAssertEqual(displayName, mood.rawValue.capitalized,
                           "displayName for \(mood) should be capitalized")
        }
    }

    func testMoodEmojiReturnsNonEmptyForAllCases() {
        for mood in Mood.allCases {
            XCTAssertFalse(mood.emoji.isEmpty,
                           "emoji for \(mood) should not be empty")
        }
    }

    func testMoodIdMatchesRawValue() {
        for mood in Mood.allCases {
            XCTAssertEqual(mood.id, mood.rawValue)
        }
    }

    func testMoodRawValueRoundTrip() {
        for mood in Mood.allCases {
            let decoded = Mood(rawValue: mood.rawValue)
            XCTAssertEqual(decoded, mood)
        }
    }
}
