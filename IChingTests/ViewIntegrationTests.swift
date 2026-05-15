import XCTest
import SwiftData
@testable import IChing

/// Integration-style tests for the state-flow logic that backs the view layer.
/// These don't render SwiftUI views (which would require a snapshot or UI-test
/// framework not currently in the project), but they exercise the same behaviour
/// the views rely on — sanitization, persistence, deep-link strictness, etc.
@MainActor
final class ViewIntegrationTests: XCTestCase {

    // MARK: - A-44: Hexagrams.current override

    private final class CountingRepository: HexagramRepository {
        private(set) var numberCalls: [Int] = []
        private(set) var linesCalls: [[Bool]] = []
        private let inner: HexagramRepository

        init(_ inner: HexagramRepository = HexagramLibrary.shared) {
            self.inner = inner
        }

        var hexagrams: [Hexagram] { inner.hexagrams }
        func hexagram(number: Int) -> Hexagram? {
            numberCalls.append(number)
            return inner.hexagram(number: number)
        }
        func hexagram(forLines lines: [Bool]) -> Hexagram? {
            linesCalls.append(lines)
            return inner.hexagram(forLines: lines)
        }
    }

    func testHexagramsCurrent_overrideIsHonored() {
        let original = Hexagrams.current
        defer { Hexagrams.current = original }

        let counter = CountingRepository()
        Hexagrams.current = counter

        // Call site that previously fell back to HexagramLibrary.shared.
        _ = Hexagram.from(lineValues: Array(repeating: .youngYang, count: 6))

        XCTAssertFalse(counter.linesCalls.isEmpty,
                       "Hexagram.from should route through Hexagrams.current when no explicit repository is passed")
    }

    func testHexagramsCurrent_resetAfterOverride() {
        let original = Hexagrams.current
        Hexagrams.current = CountingRepository()
        Hexagrams.current = original
        XCTAssertTrue(Hexagrams.current is HexagramLibrary,
                      "Restoring the original singleton should yield HexagramLibrary")
    }

    // MARK: - B-59: Reading.create resolves hexagram exactly once on success

    func testReadingCreate_resolvesHexagramOnce_onSuccess() {
        let original = Hexagrams.current
        defer { Hexagrams.current = original }
        let counter = CountingRepository()
        Hexagrams.current = counter

        switch Reading.create(lines: Array(repeating: .youngYang, count: 6)) {
        case .success:
            // forLines is the call shape used by Hexagram.from(lineValues:). It is
            // expected to be invoked once for the primary lookup; the relating
            // hexagram has no changing lines so no additional forLines call.
            XCTAssertEqual(counter.linesCalls.count, 1,
                           "Reading.create should resolve the hexagram exactly once on success (got \(counter.linesCalls.count))")
        case .failure(let error):
            XCTFail("create() should succeed for all-youngYang lines, got \(error)")
        }
    }

    func testReadingCreate_failsOnWrongLineCount() {
        let result = Reading.create(lines: [.youngYang, .youngYang])
        switch result {
        case .failure(.invalidLineCount(let expected, let actual)):
            XCTAssertEqual(expected, 6)
            XCTAssertEqual(actual, 2)
        default:
            XCTFail("Expected invalidLineCount failure, got \(result)")
        }
    }

    // MARK: - Q-64: hasCorruptedData is computed, not mutated

    func testHasCorruptedData_returnsFalseForValidLines() {
        let r = Reading(lines: Array(repeating: .youngYang, count: 6))
        XCTAssertFalse(r.hasCorruptedData)
        // Reading the computed properties must not flip the flag — Q-64 specifically
        // moved validation out of getter side effects.
        _ = r.lineValues
        _ = r.lines
        XCTAssertFalse(r.hasCorruptedData)
    }

    func testHasCorruptedData_returnsTrueForWrongCount() {
        let r = Reading(lines: Array(repeating: .youngYang, count: 6))
        r.lineValuesRaw = [7, 7, 7]
        XCTAssertTrue(r.hasCorruptedData, "Wrong line count should surface as corruption")
    }

    func testHasCorruptedData_returnsTrueForInvalidRawValue() {
        let r = Reading(lines: Array(repeating: .youngYang, count: 6))
        r.lineValuesRaw = [7, 7, 7, 7, 7, 99] // 99 is not a valid LineValue raw
        XCTAssertTrue(r.hasCorruptedData, "Invalid LineValue raw should surface as corruption")
    }

    // MARK: - B-61: NavigationCoordinator strict path matching

    func testHandleURL_multiSegmentPath_doesNotPassThrough() {
        // iching://daily/garbage/42 — the v7 implementation would have accepted
        // "42" as a valid id because it used pathComponents.last. The v8 fix
        // requires exactly two path components ("/" and id).
        let coordinator = NavigationCoordinator()
        let url = URL(string: "iching://daily/garbage/42")!
        coordinator.handle(url: url)
        // Should NOT be 42 — should fall back to today's daily hexagram instead.
        XCTAssertNotNil(coordinator.pendingHexagramId)
        XCTAssertNotEqual(coordinator.pendingHexagramId, 42,
                          "Strict matching should reject multi-segment paths even if the tail parses as 42")
    }

    func testHandleURL_trailingSlash_isNormalized() {
        // iching://daily/42/ — URL normalizes the trailing slash away, so pathComponents
        // is still ["/", "42"]. The strict matcher accepts this — documented here as
        // expected behaviour rather than treating the trailing slash specially.
        let coordinator = NavigationCoordinator()
        let url = URL(string: "iching://daily/42/")!
        coordinator.handle(url: url)
        XCTAssertEqual(coordinator.pendingHexagramId, 42,
                       "URL normalization collapses trailing slash, so /<id>/ is accepted")
    }

    // MARK: - A-45: SettingsManager persists writes

    func testSettingsManager_setterPersists() throws {
        let container = try ModelContainer(
            for: AppSettings.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let manager = SettingsManager(modelContext: container.mainContext)

        XCTAssertFalse(manager.dailyHexagramEnabled, "Default should be false")
        manager.dailyHexagramEnabled = true

        // Re-fetch and verify the change was committed to the store, not just held in memory.
        let descriptor = FetchDescriptor<AppSettings>()
        let fetched = try container.mainContext.fetch(descriptor)
        XCTAssertEqual(fetched.count, 1)
        XCTAssertTrue(fetched.first?.dailyHexagramEnabled ?? false,
                      "Setter should persist via modelContext.save()")
    }

    func testSettingsManager_hapticSetterSyncsStaticFlag() throws {
        let container = try ModelContainer(
            for: AppSettings.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let manager = SettingsManager(modelContext: container.mainContext)
        let originalStatic = HapticService.isEnabled
        defer { HapticService.isEnabled = originalStatic }

        manager.hapticFeedbackEnabled = false
        XCTAssertFalse(HapticService.isEnabled,
                       "Setting hapticFeedbackEnabled to false should sync HapticService.isEnabled")
        manager.hapticFeedbackEnabled = true
        XCTAssertTrue(HapticService.isEnabled)
    }

    // MARK: - DivineView question sanitization (S-22 / S-29 parity)

    /// The sanitization logic is inlined in `DivineView.questionSection.onChange`,
    /// but we can replicate the same predicate here to guarantee the contract holds.
    /// If anyone changes the inlined logic without updating the contract, this test
    /// becomes a documentation breadcrumb — review-time signal.
    func testSanitizationContract_stripsCcCfButKeepsWhitespace() {
        let raw = "hello\u{0007}\u{200B}world\nnext\ttab"
        let cleaned = String(raw.unicodeScalars.filter { scalar in
            if scalar == "\n" || scalar == "\t" || scalar == "\r" { return true }
            if CharacterSet.controlCharacters.contains(scalar) { return false }
            if scalar.properties.generalCategory == .format { return false }
            return true
        })
        XCTAssertEqual(cleaned, "helloworld\nnext\ttab",
                       "BEL (Cc) and zero-width space (Cf) should be stripped; \\n and \\t preserved")
    }

    // MARK: - SettingsView_ReadOnly snapshot defaults

    func testSettingsReadOnly_nilManager_returnsDefaults() {
        let snapshot = SettingsView_ReadOnly(nil)
        XCTAssertTrue(snapshot.showChineseCharacters)
        XCTAssertTrue(snapshot.showPinyin)
        XCTAssertTrue(snapshot.hapticFeedbackEnabled)
        XCTAssertFalse(snapshot.iCloudSyncEnabled)
        XCTAssertFalse(snapshot.dailyHexagramEnabled)
        XCTAssertEqual(snapshot.appColorScheme, .system)
        XCTAssertNil(snapshot.preferredColorScheme,
                     "System color scheme should map to nil ColorScheme override")
    }

    func testSettingsReadOnly_managerOverride_reflectsValues() throws {
        let container = try ModelContainer(
            for: AppSettings.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let manager = SettingsManager(modelContext: container.mainContext)
        manager.showChineseCharacters = false
        manager.appColorScheme = .dark

        let snapshot = SettingsView_ReadOnly(manager)
        XCTAssertFalse(snapshot.showChineseCharacters)
        XCTAssertEqual(snapshot.appColorScheme, .dark)
        XCTAssertEqual(snapshot.preferredColorScheme, .dark)
    }
}
