import XCTest
@testable import IChing

@MainActor
final class NavigationCoordinatorTests: XCTestCase {

    private var coordinator: NavigationCoordinator!

    override func setUp() {
        super.setUp()
        coordinator = NavigationCoordinator.shared
        coordinator.pendingHexagramId = nil
    }

    override func tearDown() {
        coordinator.pendingHexagramId = nil
        coordinator = nil
        super.tearDown()
    }

    // MARK: - Valid Deep Links

    func testHandleURL_validDailyHexagram42() {
        let url = URL(string: "iching://daily/42")!
        coordinator.handle(url: url)
        XCTAssertEqual(coordinator.pendingHexagramId, 42)
    }

    func testHandleURL_validDailyHexagram1_lowerBoundary() {
        let url = URL(string: "iching://daily/1")!
        coordinator.handle(url: url)
        XCTAssertEqual(coordinator.pendingHexagramId, 1)
    }

    func testHandleURL_validDailyHexagram64_upperBoundary() {
        let url = URL(string: "iching://daily/64")!
        coordinator.handle(url: url)
        XCTAssertEqual(coordinator.pendingHexagramId, 64)
    }

    // MARK: - Malformed Daily URLs (Fallback to Daily Hexagram)

    func testHandleURL_outOfRangeZero_fallsThroughToDaily() {
        let url = URL(string: "iching://daily/0")!
        coordinator.handle(url: url)
        XCTAssertNotNil(coordinator.pendingHexagramId)
        XCTAssertTrue((1...64).contains(coordinator.pendingHexagramId!))
    }

    func testHandleURL_outOfRange65_fallsThroughToDaily() {
        let url = URL(string: "iching://daily/65")!
        coordinator.handle(url: url)
        XCTAssertNotNil(coordinator.pendingHexagramId)
        XCTAssertTrue((1...64).contains(coordinator.pendingHexagramId!))
    }

    func testHandleURL_nonNumericPath_fallsThroughToDaily() {
        let url = URL(string: "iching://daily/abc")!
        coordinator.handle(url: url)
        XCTAssertNotNil(coordinator.pendingHexagramId)
        XCTAssertTrue((1...64).contains(coordinator.pendingHexagramId!))
    }

    func testHandleURL_noPath_fallsThroughToDaily() {
        let url = URL(string: "iching://daily")!
        coordinator.handle(url: url)
        XCTAssertNotNil(coordinator.pendingHexagramId)
        XCTAssertTrue((1...64).contains(coordinator.pendingHexagramId!))
    }

    // MARK: - Wrong Scheme / Host

    func testHandleURL_wrongScheme_doesNotSetPending() {
        let url = URL(string: "https://daily/42")!
        coordinator.handle(url: url)
        XCTAssertNil(coordinator.pendingHexagramId)
    }

    func testHandleURL_wrongHost_doesNotSetPending() {
        let url = URL(string: "iching://library/42")!
        coordinator.handle(url: url)
        XCTAssertNil(coordinator.pendingHexagramId)
    }

    // MARK: - consumePendingHexagram

    func testConsumePendingHexagram_returnsIdAndClearsIt() {
        coordinator.pendingHexagramId = 33
        let consumed = coordinator.consumePendingHexagram()
        XCTAssertEqual(consumed, 33)
        XCTAssertNil(coordinator.pendingHexagramId)
    }

    func testConsumePendingHexagram_returnsNilWhenNothingPending() {
        let consumed = coordinator.consumePendingHexagram()
        XCTAssertNil(consumed)
    }
}
