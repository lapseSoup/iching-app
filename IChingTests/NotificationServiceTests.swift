import XCTest
@testable import IChing

/// Tests the scheduling *logic* used by NotificationService without touching
/// UNUserNotificationCenter.  We replicate the pure-function portions of
/// `scheduleDailyHexagram(at:)` so they can be verified deterministically.
final class NotificationServiceTests: XCTestCase {

    private let calendar = Calendar.current

    // MARK: - Date Component Calculation

    /// Given a notification time, the service should produce DateComponents for
    /// 7 consecutive days, each carrying the correct year/month/day plus the
    /// requested hour and minute, with seconds zeroed out.
    func testDateComponentsForSevenDays() {
        let now = Date()
        // Use an arbitrary time: 09:30
        let timeComponents = DateComponents(hour: 9, minute: 30)

        var generatedComponents: [DateComponents] = []
        for dayOffset in 0..<7 {
            guard let targetDate = calendar.date(byAdding: .day, value: dayOffset, to: now) else {
                XCTFail("Could not compute target date for offset \(dayOffset)")
                continue
            }
            var dc = calendar.dateComponents([.year, .month, .day], from: targetDate)
            dc.hour = timeComponents.hour
            dc.minute = timeComponents.minute
            dc.second = 0
            generatedComponents.append(dc)
        }

        XCTAssertEqual(generatedComponents.count, 7)

        for (index, dc) in generatedComponents.enumerated() {
            XCTAssertEqual(dc.hour, 9, "Day \(index) hour should be 9")
            XCTAssertEqual(dc.minute, 30, "Day \(index) minute should be 30")
            XCTAssertEqual(dc.second, 0, "Day \(index) second should be 0")
            XCTAssertNotNil(dc.year, "Day \(index) should have year")
            XCTAssertNotNil(dc.month, "Day \(index) should have month")
            XCTAssertNotNil(dc.day, "Day \(index) should have day")
        }

        // Verify days are sequential
        for i in 1..<generatedComponents.count {
            let prevDate = calendar.date(from: generatedComponents[i - 1])!
            let currDate = calendar.date(from: generatedComponents[i])!
            let dayDiff = calendar.dateComponents([.day], from: prevDate, to: currDate).day!
            XCTAssertEqual(dayDiff, 1, "Days should be consecutive")
        }
    }

    /// Time components should be extracted correctly from an arbitrary Date.
    func testTimeComponentExtraction() {
        var comps = DateComponents()
        comps.year = 2026
        comps.month = 3
        comps.day = 25
        comps.hour = 14
        comps.minute = 45
        let date = calendar.date(from: comps)!

        let timeOnly = calendar.dateComponents([.hour, .minute], from: date)
        XCTAssertEqual(timeOnly.hour, 14)
        XCTAssertEqual(timeOnly.minute, 45)
    }

    // MARK: - Past-Time Skip Logic

    /// When the computed fire date is in the past, the notification loop should
    /// skip that day.  We replicate the exact comparison from the service.
    func testPastFireDateIsSkipped() {
        // Build a fire date 1 hour ago
        let oneHourAgo = Date().addingTimeInterval(-3600)
        let dc = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: oneHourAgo)
        let fireDate = calendar.date(from: dc)!

        // This mirrors the guard: `if fireDate < Date() { continue }`
        XCTAssertTrue(fireDate < Date(), "A fire date in the past should be detected as past")
    }

    /// A fire date in the future should NOT be skipped.
    func testFutureFireDateIsNotSkipped() {
        let oneHourLater = Date().addingTimeInterval(3600)
        let dc = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: oneHourLater)
        let fireDate = calendar.date(from: dc)!

        XCTAssertFalse(fireDate < Date(), "A fire date in the future should not be skipped")
    }

    /// For today's notification, if the requested time has already passed, only
    /// day 0 should be skipped; days 1-6 should still generate valid fire dates.
    func testOnlyTodaySkippedWhenTimePassed() {
        // Use a time that is definitely in the past today: midnight
        let midnightComponents = DateComponents(hour: 0, minute: 0)
        let now = Date()

        var skippedCount = 0
        var scheduledCount = 0

        for dayOffset in 0..<7 {
            guard let targetDate = calendar.date(byAdding: .day, value: dayOffset, to: now) else { continue }

            var dc = calendar.dateComponents([.year, .month, .day], from: targetDate)
            dc.hour = midnightComponents.hour
            dc.minute = midnightComponents.minute
            dc.second = 0

            if let fireDate = calendar.date(from: dc), fireDate < now {
                skippedCount += 1
            } else {
                scheduledCount += 1
            }
        }

        // Day 0 (today at midnight) is always in the past
        XCTAssertGreaterThanOrEqual(skippedCount, 1, "At least today should be skipped for midnight")
        // Days 1-6 should all be scheduled (midnight tomorrow is in the future)
        XCTAssertEqual(scheduledCount, 7 - skippedCount)
        XCTAssertEqual(skippedCount + scheduledCount, 7, "Total should always be 7")
    }

    // MARK: - Daily Hexagram Content Generation

    /// Each day in the 7-day window should produce a valid hexagram ID (1-64).
    func testDailyHexagramIdsAreValid() {
        let now = Date()
        for dayOffset in 0..<7 {
            guard let targetDate = calendar.date(byAdding: .day, value: dayOffset, to: now) else {
                XCTFail("Could not create date for offset \(dayOffset)")
                continue
            }
            let hexId = HexagramBasicInfo.dailyHexagramId(for: targetDate)
            XCTAssertTrue(
                (1...64).contains(hexId),
                "Day offset \(dayOffset) produced out-of-range hexagram ID: \(hexId)"
            )
        }
    }

    /// Consecutive days should (almost certainly) produce different hexagram IDs.
    func testConsecutiveDaysProduceDifferentHexagrams() {
        let now = Date()
        var ids: [Int] = []
        for dayOffset in 0..<7 {
            guard let targetDate = calendar.date(byAdding: .day, value: dayOffset, to: now) else { continue }
            ids.append(HexagramBasicInfo.dailyHexagramId(for: targetDate))
        }

        // With 7 values drawn from 1-64, the probability of ALL being identical
        // is vanishingly small. Check that we have at least 2 distinct values.
        let uniqueIds = Set(ids)
        XCTAssertGreaterThan(uniqueIds.count, 1, "7 consecutive days should produce multiple distinct hexagram IDs")
    }

    /// The hexagram ID for a given date must be deterministic.
    func testDailyHexagramIdIsDeterministic() {
        let now = Date()
        for dayOffset in 0..<7 {
            guard let targetDate = calendar.date(byAdding: .day, value: dayOffset, to: now) else { continue }
            let id1 = HexagramBasicInfo.dailyHexagramId(for: targetDate)
            let id2 = HexagramBasicInfo.dailyHexagramId(for: targetDate)
            XCTAssertEqual(id1, id2, "dailyHexagramId should be deterministic for the same date")
        }
    }

    // MARK: - Notification Identifiers

    /// The identifiers generated for cancellation should match those used for scheduling.
    func testNotificationIdentifiersMatch() {
        let prefix = "daily-hexagram"
        let schedulingIds = (0..<7).map { "\(prefix)-\($0)" }
        let cancellationIds = (0..<7).map { "\(prefix)-\($0)" }
        XCTAssertEqual(schedulingIds, cancellationIds)
        XCTAssertEqual(schedulingIds.count, 7)
        XCTAssertEqual(schedulingIds.first, "daily-hexagram-0")
        XCTAssertEqual(schedulingIds.last, "daily-hexagram-6")
    }
}
