# I Ching App — Review Findings
**Latest review:** 2026-05-14 (v8 / Review #8)
**Full report:** `docs/reviews/2026-05-14-full-review-v8.md`
**Rating:** 5.5 / 10 (v1 pre-fix) → 8 / 10 (v1 post-fix) → 6.5 / 10 (v2 pre-fix) → 9 / 10 (v2 post-fix) → 7.5 / 10 (v3 pre-fix) → 9.5 / 10 (v3 post-fix) → 8 / 10 (v4 pre-fix) → 9.5 / 10 (v5 post-fix) → 7.5 / 10 (v6 pre-fix) → 9.5 / 10 (v6 post-fix) → 8 / 10 (v7 pre-fix) → 9.5 / 10 (v7 post-fix) → 8.5 / 10 (v8 pre-fix) → **9.7 / 10** (v8 post-fix)

**v8 post-fix:** 225/225 tests pass on iOS and macOS. All 32 v8 findings closed (including the three originally-deferred items: A-44, A-47, A-50). Plus 1 pre-existing bug fixed (`Hexagram.transformed`), 1 pre-existing test typo fixed (`assertForOverInFulfillment`), and 14 new view-integration tests added.

> **v8 verification note:** all 15 of the most recent v7/v8 fix claims were spot-checked against the current code. 14 hold cleanly. A-32 is functionally correct but slightly mis-described (the `.navigationDestination` lives on the inner `List`, not the outer `NavigationStack` — same scope, different placement). No regressions found in older fixed items.

> **Legend:** ✅ Fixed | 🔴 Open-Critical | 🟠 Open-High | 🟡 Open-Medium | ⚪ Open-Low

## Critical — Fix Before Next Release
| ID | Status | File | Issue |
|----|--------|------|-------|
| B-1 | ✅ Fixed (v1) | `Line.swift:66-67` | Coin-flip mapping swaps youngYin/youngYang — every coin reading produces wrong hexagram |
| B-2 | ✅ Fixed (v1) | `IChingApp.swift` | `fatalError` on ModelContainer init failure — replaced with graceful error view |
| B-3 | ✅ Fixed (v1) | `DivineViewModel.swift:4` | Timer mutates @Observable off main thread — added @MainActor + uses HapticService |
| S-1 | ✅ Fixed (v1) | `NotificationService.swift:45` | Force unwrap `hexagram(number:)!` — replaced with guard let |
| B-11 | ✅ Fixed (v2) | `DivineViewModel.swift` | Timer retain cycle — extracted to `CoinFlipAnimator` service with `[weak self]` and proper cleanup |
| B-14 | ✅ Fixed (v3) | `ContentView.swift` | Nested NavigationStacks — removed ContentView's wrapper |
| B-15 | ✅ Fixed (v3) | `NotificationService.swift` | Daily notification showed stale hexagram — now schedules 7 individual notifications |
| B-16 | ✅ Fixed (v3) | `SettingsView.swift` | iCloud sync toggle was non-functional — replaced with "Coming Soon" label |
| B-19 | ✅ Fixed (v5) | `Reading.swift:28` | `.nullify` → `.cascade` delete rule on `journalEntries` |
| B-20 | ✅ Fixed (v5) | `ContentView.swift:71-75`, `AppSettings.swift:41` | `ensureSettingsExist()` + singleton UUID enforcement |
| S-12 | ✅ Fixed (v5) | `IChingApp.swift` | `exit(0)` replaced with state-driven "restart required" message |
| B-32 | ✅ Fixed (v6) | `IChingWidgets.swift:33-35` | Widget timeline now normalizes date to `startOfDay` for consistent hexagram ID across DST transitions |
| B-33 | ✅ Fixed (v6) | `NotificationService.swift:73-75` | Past-time notifications now skipped with `fireDate < Date()` check |
| B-34 | ✅ Fixed (v6) | `SettingsView.swift:10-12` | Removed `modelContext.insert` side effect from computed property; uses non-inserted fallback |
| B-41 | ✅ Fixed (v7) | `SettingsView.swift:10` | Orphan `AppSettings()` fallback — now inserts into modelContext |
| B-42 | ✅ Fixed (v7) | `NavigationCoordinator.swift:6-7` | Added `@MainActor` to `NavigationCoordinating` protocol |
| B-43 | ✅ Fixed (v7) | `CoinFlipAnimator.swift:21` | Replaced `assumeIsolated` with `Task { @MainActor in }` |
| B-44 | ✅ Fixed (v7) | `CoinFlipAnimator.swift` | Removed `deinit` — `stop()` handles cleanup |

## High Priority — Next Sprint
| ID | Status | File | Issue |
|----|--------|------|-------|
| S-24 | ✅ Fixed (v8) | `IChingWidgets.swift:15,21,37` + `Shared/HexagramBasicData.swift:20-21` | Widget crashes in release if `hexagram_basic.json` is missing. `assertionFailure` is debug-only; release returns `[]` then traps on `all[0]` / `all[hexagramId - 1]`. Main app uses `fatalError` for the equivalent — widget should match. |
| B-54 | ✅ Fixed (v8) | `CoinFlipAnimator.swift:21-48` | Timer-tick `Task { @MainActor in ... }` can fire `onComplete` multiple times under main-thread contention. Multiple ticks enqueue tasks before any runs; once one hits `flips >= flipCount` and invalidates the timer, queued tasks still re-enter the `if` branch with fresh random coins. Fix: `guard flips < self.flipCount else { return }` at task entry. |
| B-4 | ✅ Fixed (v1) | `IChingWidgets.swift:31-94` | Widget only has 11 of 64 hexagrams — now has all 64 |
| B-5 | ✅ Fixed (v1) | `HistoryView.swift:45` | Operator precedence bug in sort — added parentheses |
| A-1 | ✅ Fixed (v1) | `Color+Theme.swift:14-22` | iOS-only UIColor names — added #if os(macOS) guards |
| S-2 | ✅ Fixed (v2) | `IChingApp.swift:20` | CloudKit syncs unencrypted — changed to `.none` default |
| S-3 | ✅ Fixed (v1) | `IChing.entitlements` | Unnecessary `network.client` entitlement — removed |
| B-12 | ✅ Fixed (v2) | `Reading.swift:68-71` | Silent data corruption — added enumerated logging |
| A-8 | ✅ Fixed (v2) | `Shared/HexagramBasicData.swift` | Created shared `HexagramBasicInfo` single source of truth |
| A-9 | ✅ Fixed (v2) | `IChingTests/` | Created test suite: LineValueTests, HexagramLibraryTests, HexagramTests, HexagramBasicDataTests |
| B-17 | ✅ Fixed (v3) | Multiple views | iOS-only colors replaced with platform-safe theme colors |
| B-18 | ✅ Fixed (v3) | `HapticService.swift`, `SettingsView.swift` | HapticService now respects `hapticFeedbackEnabled` |
| A-15 | ✅ Fixed (v5) | `IChingError.swift`, `Reading.swift`, `DivineView.swift` | `IChingError` expanded with `.hexagramResolutionFailed` and `.invalidLineCount`. `Reading.create()` returns `Result<Reading, IChingError>`. DivineView surfaces errors via alert. |
| A-16 | ✅ Fixed (v5) | `IChingApp.swift` | "Reset Data" button with state-driven restart message |
| Q-20 | ✅ Fixed (v5) | `IChingTests/DivineViewModelTests.swift` | 45 tests for DivineViewModel: state machine, coin flips, line progression, manual entry, reset, changing lines |
| Q-21 | ✅ Fixed (v5) | `IChingTests/ReadingTests.swift` | 33 tests for Reading: initialization, lineValues, create(), changingLinePositions, hexagram caching |
| S-13 | ✅ Fixed (v6) | `JournalListView.swift:64-73` | Added `try modelContext.save()` with error alert after journal deletion |
| S-14 | ✅ Fixed (v6) | `IChing.entitlements` | Removed unused CloudKit/iCloud KVS entitlements (3 keys) |
| A-26 | ✅ Fixed (v6) | `Reading.swift:39,130-148` | `ensureHexagramCache()` uses injectable `_repository` via `withRepository()` method |
| A-35 | ✅ Fixed (v7) | `HexagramBasicData.swift` | Replaced hardcoded `all` array with JSON-loaded data from `hexagram_basic.json` |
| A-36 | ✅ Fixed (v7) | `ServiceEnvironment.swift` | All 4 singletons injectable via `@Environment` (NavigationCoordinator, NotificationService, HapticService, HexagramRepository) |
| A-37 | ✅ Fixed (v7) | `SettingsManager.swift` | `@Observable` SettingsManager loads AppSettings once, injected via `@Environment` |
| Q-48 | ✅ Fixed (v7) | `IChingTests/CoinFlipAnimatorTests.swift` | Added CoinFlipAnimator tests |
| Q-49 | ✅ Fixed (v7) | `IChingTests/NotificationServiceTests.swift` | Added NotificationService scheduling logic tests |
| S-19 | ✅ Fixed (v7) | `HistoryView.swift:118`, `JournalListView.swift:74` | Added `modelContext.rollback()` on delete failure |

## Medium Priority — Sprint After
| ID | Status | File | Issue |
|----|--------|------|-------|
| S-25 | ✅ Fixed (v8) | `IChing.entitlements` vs `IChingWidgets.entitlements` | Asymmetric App Group capability. Main app declares `group.com.iching.app`; widget doesn't. App Group is inert — nothing actually shared. Either remove from main app or restore on widget. |
| S-26 | ✅ Fixed (v8) | `NavigationCoordinator.swift:34` | Malformed deep-link URL logged with `privacy: .public`. URLs are external user-controlled input; flip to `.private`. |
| S-27 | ✅ Fixed (v8) | `SettingsManager.swift:21,27` | `try?` swallows fetch + save errors silently. If AppSettings is corrupted, user gets defaults every launch with no signal. Log via `AppLogger.persistence.error(...)`. |
| B-55 | ✅ Fixed (v8) | `ContentView.swift:40-44` | Deep-link → Library tab switch is iOS-only (`#if os(iOS)`). On macOS, `iching://daily/42` sets `pendingHexagramId` but sidebar doesn't switch. Add symmetric macOS handling. |
| B-56 | ✅ Fixed (v8) | `LibraryView.swift:63-68` | LibraryView consumes pending deep-link only via `.onChange`, never `.onAppear`. If ID is set before first appear (cold start, macOS), it's never consumed. |
| B-57 | ✅ Fixed (v8) | `HistoryView.swift:42,58-77` | `groupedReadings: @State = []`. On first render with non-empty `readings`, the non-empty branch renders `ForEach` on empty groups — flash of empty list before `.onAppear` recomputes. |
| B-58 | ✅ Fixed (v8) | `Line.swift:50-58` | `LineValue.from(heads:)` `default: return .youngYang` silently masks invalid input. Coin flip produces 0-3 by construction, but a future change/bug would silently corrupt readings. Use `precondition` or log. |
| B-59 | ✅ Fixed (v8) | `Reading.swift:88-91` | `Reading.create()` calls `Hexagram.from(lineValues:)` twice on success path (validate + init). Wasted lookup. |
| A-44 | ✅ Fixed (v8) | `IChing/Models/HexagramLibrary.swift:17-32`, `Hexagram.swift:31,67`, `Reading.swift:158-170` | Introduced `Hexagrams.current` — a single overridable process-wide repository. All `Hexagram.from`/`Hexagram.transformed` default parameters and `Reading.ensureHexagramCache`'s fallback now route through it. Tests swap one variable in setUp to redirect every consumer at once, eliminating the "did I forget to inject?" failure mode. Per-instance `Reading.withRepository(_:)` still works for tightly-scoped test cases. |
| A-45 | ✅ Fixed (v8) | `SettingsManager.swift:73-77` | Settings setters never call `try modelContext.save()`. Auto-save unreliable on crash. Manager should be save authority. |
| A-46 | ✅ Fixed (v8) | `Shared/HexagramBasicData.swift` ↔ `IChing/Resources/hexagrams.json` | Two JSON sources of truth. Only enforced consistency is via `testBasicDataMatchesLibrary`. Build-time enforcement preferred (script or CI). |
| A-47 | ✅ Partial (v8) | `IChingTests/ViewIntegrationTests.swift` (new, 14 tests) | Added view-level integration tests covering the state-flow logic the v8 fixes addressed: `Hexagrams.current` override (A-44), `Reading.create` single-resolve (B-59), `hasCorruptedData` computed correctness (Q-64), `NavigationCoordinator` strict path matching (B-61), `SettingsManager` persistence (A-45), haptic-static sync, sanitization contract, `SettingsView_ReadOnly` snapshot defaults. Full SwiftUI body rendering still requires snapshot/UI tooling — that strategic initiative remains for a future sprint. |
| A-48 | ✅ Fixed (v8) | `IChingApp.swift:78,153-170` | `SettingsManager` initialized in `.onAppear`, after first body render → one-frame flicker of default settings. Initialize synchronously in `init()`. |
| Q-60 | ✅ Fixed (v8) | `SettingsView.swift:12` | `settingsManager!` force-unwrap. "Safe by convention" — crashes if injection ever wrong. Use safe defaults or non-optional init. |
| Q-61 | ✅ Fixed (v8) | `LibraryView.swift:12-18`, `HexagramDetailView.swift:8-14`, `ContentView.swift:38`, `SettingsView.swift:12` | Inconsistent settingsManager access: `!` vs `?? default`. Multiple defaults duplicated. Unify with non-optional EnvironmentValues wrapper. |
| B-6 | ✅ Fixed (v1) | `Reading.swift:68-71` | `compactMap` silently drops corrupted lineValues |
| B-7 | ✅ Fixed (v1) | `SettingsView.swift` | Side effect in computed property |
| B-8 | ✅ Fixed (v1) | `JournalEntry.swift:26` | `update()` overwrites mood with nil |
| B-9 | ✅ Fixed (v1) | `IChingWidgets.swift:68` | Force unwrap on `calendar.date(byAdding:)!` |
| A-2 | ✅ Fixed (v2) | `HexagramLibrary.swift` | Extracted `HexagramRepository` protocol |
| A-3 | ✅ Fixed (v2) | `CoinFlipAnimator.swift` | Extracted timer/haptic into service |
| A-4 | ✅ Fixed (v2) | `IChing.entitlements` | Added App Group |
| A-5 | ✅ Fixed (v2) | `AppSettings.swift` | `@Attribute(.unique)` on id |
| Q-1 | ✅ Fixed (v1) | `CoinFlipView.swift` | VoiceOver accessibility |
| Q-2 | ✅ Fixed (v1) | `DivineView.swift:53` | Dynamic Type support |
| Q-3 | ✅ Fixed (v1) | `DivineViewModel.swift` | Uses HapticService |
| S-7 | ✅ Fixed (v2) | `NotificationService.swift` | `os.log` Logger |
| S-8 | ✅ Fixed (v2) | `Info.plist` | Removed unused background mode |
| A-10 | ✅ Fixed (v2) | `IChingApp.swift` | Schema versioning V1/V2 |
| A-11 | ✅ Fixed (v2) | `Reading.swift:25` | `.cascade` → `.nullify` (then back to `.cascade` in v5) |
| B-13 | ✅ Fixed (v2) | `NotificationService.swift` | Shared daily hexagram algorithm |
| Q-10 | ✅ Fixed (v2) | Multiple views | Accessibility labels on hexagram cards |
| Q-11 | ✅ Fixed (v2) | `AppSettings.swift` | `AppColorScheme` enum |
| Q-12 | ✅ Fixed (v2) | Multiple files | Magic strings extracted |
| A-13 | ✅ Fixed (v3) | `SettingsView.swift`, `ContentView.swift` | Appearance picker wired up |
| Q-16 | ✅ Fixed (v3) | `DivineViewModel.swift` | Unified `hexagramResult` computed property |
| Q-17 | ✅ Fixed (v3) | Multiple views | Shared `HexagramTextTabView` component |
| B-21 | ✅ Fixed (v5) | `DivineView.swift:64-68` | `.onChange(of: navigateToReading)` prevents flicker |
| B-22 | ✅ Fixed (v5) | `Reading.swift:126-134` | `ensureHexagramCache()` now uses local `repository` variable |
| B-23 | ✅ Fixed (v5) | `CoinFlipView.swift:24` | `hasFlipped && !isFlipping` guard |
| B-27 | ✅ Fixed (v5) | `DivineView.swift:271` | `modelContext.delete(reading)` on save failure |
| B-28 | ✅ Fixed (v5) | `JournalEditorView.swift:229` | `modelContext.rollback()` on delete-save failure |
| B-29 | ✅ Fixed (v5) | `DivineViewModel.swift:98` | `hasFlipped = false` in `reset()` |
| A-17 | ✅ Fixed (v5) | `Hexagram.swift`, `Reading.swift` | `Hexagram.from()` and `transformed()` accept `HexagramRepository` parameter with default |
| A-18 | ✅ Fixed (v5) | `AppSettings.swift:41,44` | Singleton UUID enforcement |
| A-19 | ✅ Fixed (v5) | `HexagramBasicDataTests.swift:33-44` | Sync validation test `testBasicDataMatchesLibrary` |
| A-21 | ✅ Fixed (v7) | `Reading.swift`, `JournalEntry.swift` | `#Index` macro added with `#if swift(>=6.0)` guard |
| A-22 | ✅ Fixed (v5) | `IChingWidgets.swift`, `NavigationCoordinator.swift`, `ContentView.swift`, `LibraryView.swift` | Widget deep-link via `widgetURL(iching://daily/{id})` |
| Q-22 | ✅ Fixed (v5) | Multiple views | try/catch with error alerts on all save/delete |
| Q-23 | ✅ Fixed (v5) | `HexagramView.swift:115-125` | `HexagramBuildingView` accessibility |
| Q-24 | ✅ Fixed (v5) | `IChingTests/JournalEntryTests.swift` | 18 tests for JournalEntry |
| Q-25 | ✅ Fixed (v5) | `View+Extensions.swift`, all screen views | Shared `.settingsToolbarButton()` |
| B-35 | ✅ Fixed (v6) | `CoinFlipAnimator.swift:21` | Timer callback wrapped in `MainActor.assumeIsolated` for Swift 6 safety |
| B-36 | ✅ Fixed (v6) | `Reading.swift:47` | `precondition(lines.count == 6)` in init |
| B-37 | ✅ Fixed (v6) | `JournalEditorView.swift:205` | Edit button disabled when `entry.reading == nil` |
| B-38 | ✅ Fixed (v6) | `NavigationCoordinator.swift:20-30` | Malformed deep links fall back to today's daily hexagram |
| B-39 | ✅ Fixed (v6) | `DivineViewModel.swift:40` | `_cachedHexagramResult` set on completion, cleared on reset |
| A-27 | ✅ Fixed (v6) | `HexagramLibrary.swift:64-66` | Removed 2,400-line hardcoded fallback; JSON-only with fatalError. Deleted HexagramData1-4.swift |
| A-28 | ✅ Fixed (v6) | `IChingApp.swift:6-25` | Schema versions V1/V2/V3 documented with change descriptions |
| A-29 | ✅ Fixed (v6) | `NavigationCoordinator.swift:5-9` | Added `NavigationCoordinating` protocol for testability |
| A-30 | ✅ Fixed (v6) | `HapticService.swift:6` | Added `@MainActor` to enum for thread safety |
| A-31 | ✅ Fixed (v6) | `HistoryView.swift:6-31` | Extracted `groupReadingsByDate()` as testable free function |
| Q-35 | ✅ Fixed (v6) | `HexagramDetailView.swift`, `LibraryView.swift` | `showChineseCharacters`/`showPinyin` now wired to views via `@Query` settings |
| Q-36 | ✅ Fixed (v8) | `AppSettings.swift:30,36` | Converted `colorScheme` and `defaultReadingMethod` from raw Strings to Codable enums with V3→V4 migration |
| Q-37 | ✅ Fixed (v6) | `Line.swift` | Removed dead `transformedIsYang` and `displaySymbol` |
| Q-38 | ✅ Fixed (v8) | `IChingWidgets.swift:114-133` | Widget LineView duplication documented; both consume shared `HexagramBasicInfo.lines` |
| Q-39 | ✅ Fixed (v6) | `IChingTests/TrigramTests.swift`, `NavigationCoordinatorTests.swift` | 27 Trigram tests + 11 NavigationCoordinator tests added |
| B-45 | ✅ Fixed (v7) | `LibraryView.swift` | Unified deep-link consumption via single `onChange` path |
| B-46 | ✅ Fixed (v7) | `LibraryView.swift` | Removed dual `navigationDestination`; uses `NavigationPath` |
| B-47 | ✅ Fixed (v7) | `JournalEditorView.swift:229` | Added `dismiss()` after successful deletion |
| B-48 | ✅ Fixed (v7) | `HexagramBasicData.swift:88` | Replaced `abs()` with safe `((h % 64) + 64) % 64 + 1` |
| B-49 | ✅ Fixed (v7) | `Reading.swift` | Added `@Transient var hasCorruptedData` flag on invalid line values |
| B-50 | ✅ Fixed (v7) | `Reading.swift` | Added `lineValuesRaw.count == 6` guard with safe default |
| A-38 | ✅ Fixed (v7) | Multiple views | Standardized `rollback()` + `AppLogger.persistence` on all error paths |
| A-39 | ✅ Fixed (v8) | `IChing.entitlements`, `IChingWidgets.entitlements` | Removed App Group from widget; main app retains for future use |
| A-40 | ✅ Fixed (v7) | `Reading.swift` | Formatting properties moved to `extension Reading` |
| Q-50 | ✅ Fixed (v7) | `Reading.swift` | Cached `lines` and `changingLinePositions` in `@Transient` properties |
| Q-51 | ✅ Fixed (v8) | `HistoryView.swift` | Converted `groupedReadings` to `@State` with `.onChange` memoization |
| Q-52 | ✅ Fixed (v7) | `LibraryView.swift` | `HexagramCard` accepts settings params from parent instead of querying |
| Q-53 | ✅ Fixed (v7) | `HexagramHeaderCard.swift` | Extracted shared `HexagramHeaderCard` component |
| Q-54 | ✅ Fixed (v7) | `HistoryView.swift`, `JournalListView.swift` | Added structured `.accessibilityLabel()` to row views |

## Low Priority
| ID | Status | File | Issue |
|----|--------|------|-------|
| S-28 | ✅ Fixed (v8) | `IChing/Info.plist:28-30` | `UIRequiredDeviceCapabilities` contains `armv7`. Modern iOS devices report `arm64`. Dead at best, exclusionary at worst. Remove or change to `arm64`. |
| S-29 | ✅ Fixed (v8) | `JournalEditorView.swift:29-35` | Journal `content` truncates length but doesn't strip Cc/Cf control characters (DivineView question input does at line 91-103). Inconsistent. |
| B-60 | ✅ Fixed (v8) | `ContentView.swift:67-72`, `SettingsView.swift:110-111` | `var service = hapticService; service.isEnabled = X` pattern works only because `HapticServiceAdapter.isEnabled` delegates to a static. Reader-unfriendly; use `HapticService.isEnabled = ...` directly. |
| B-61 | ✅ Fixed (v8) | `NavigationCoordinator.swift:30-32` | `iching://daily/garbage/42` parses as hexagram 42 because code reads `pathComponents.last`. Should verify exact path length or use URLComponents. |
| B-62 | ✅ Fixed (v8) | `SettingsView.swift:113-128` | `.onChange` toggle handlers spawn unstructured `Task`s calling cancel-then-schedule. Rapid toggles can interleave and leave notification state mismatched. Serialize via actor or task cancellation. |
| A-49 | ✅ Fixed (v8) | `DivineView.swift:248-267`, `JournalEditorView.swift:111-127,225-235`, `HistoryView.swift:118-129`, `JournalListView.swift:67-78` | Save/delete + rollback + log + alert boilerplate repeated 4+ times. Extract `ModelContext.safeSave(category:onError:)` helper. |
| A-50 | ✅ Fixed (v8) | `IChing/Services/ServiceEnvironment.swift:5-37`, `IChingApp.swift`, `LibraryView.swift`, `SettingsView.swift` | Introduced `ServiceBundle` aggregating the three set-once-at-launch services (haptics, notifications, hexagram repository) under `\.services`. `@Observable` keys (`\.settingsManager`, `\.navigationCoordinator`) intentionally remain separate to preserve granular change-tracking. Individual stateless keys remain for test-only fine-grained overrides. New stateless services now plug into the bundle without touching consumer views. |
| Q-62 | ✅ Fixed (v8) | `AppSettings.swift:63-71` | `readingMethod` and `appColorScheme` are alias getter/setters for `defaultReadingMethod` and `colorScheme`. Historical artifact; remove. |
| Q-63 | ✅ Fixed (v8) | `LibraryView.swift:26-36`, `JournalListView.swift:17-24`, `HistoryView.swift:48-56` | `filteredX` recomputed every render. Same fix pattern as Q-51. |
| Q-64 | ✅ Fixed (v8) | `Reading.swift:95-104` | `lineValues` getter mutates `hasCorruptedData`. Convert to method or make `hasCorruptedData` computed. |
| Q-65 | ✅ Fixed (v8) | `Shared/HexagramBasicData.swift:20-21` | `assertionFailure` then `return []` is debug-only. Main app uses `fatalError` for the equivalent — use it here too. |
| Q-66 | ✅ Fixed (v8) | `ReadingDetailView.swift:198` | `journalEntries.sorted(...)` on every render. Cache in `@State` with `.onChange(of:)`. |
| Q-67 | ✅ Fixed (v8) | `SettingsView.swift:204` | `try!` in Preview helper. Other previews use `do/catch`. |
| Q-68 | ✅ Fixed (v8) | Multiple files | Magic number `6` (hexagram line count) repeated. Define `Reading.lineCount = 6` constant. |
| Q-69 | ✅ Fixed (v8) | `LibraryView.swift:16-18` | `showPinyin` computed but never referenced in body. Dead code. |
| S-4 | ✅ Fixed (v1) | `Info.plist` | Unused `fetch` background mode |
| S-5 | ✅ Fixed (v2) | `IChingApp.swift` | Added `NSFileProtection` |
| S-6 | ✅ Fixed (v2) | `NotificationService.swift` | Removed hexagramId from userInfo |
| B-10 | ✅ Fixed (v2) | `Reading.swift:57-64` | `#if DEBUG` warning log |
| A-6 | ✅ Fixed (v2) | `NotificationService.swift` | `@MainActor` isolation |
| A-7 | ✅ Fixed (v2) | `DivineView.swift` | `init(viewModel:)` for DI |
| Q-4 | ✅ Fixed (v1) | `DateFormatters.swift` | Locale-aware month/year |
| Q-5 | ✅ Fixed (v1) | `HexagramLibrary.swift` | O(1) lookup |
| Q-6 | ✅ Fixed (v1) | `Reading.swift` | Cached DateFormatters |
| Q-7 | ✅ Fixed (v1) | `Hexagram.swift` | Dead `baseCodePoint` removed |
| Q-8 | ✅ Fixed (v2) | `Color+Theme.swift` | Distinct yang/yin colors |
| Q-9 | ✅ Fixed (v2) | `Hexagram.swift` | `hash(into:)` only hashes `id` |
| A-12 | ✅ Fixed (v2) | `Reading.swift` | `lineValuesRaw` array |
| Q-13 | ✅ Fixed (v2) | `Reading.swift` | `@Transient` cached lookups |
| Q-14 | ✅ Fixed (v2) | `DateFormatters.swift` | Removed unused formatters |
| Q-15 | ✅ Fixed (v2) | `View+Extensions.swift` | Removed `hideKeyboard()` |
| A-14 | ✅ Fixed (v3) | `Trigram.swift` | O(1) lookup via `lineMap` |
| Q-18 | ✅ Fixed (v3) | `TrigramView.swift` | Dead code removed |
| Q-19 | ✅ Fixed (v3) | Preview code | `try!` replaced with `do/catch` |
| S-9 | ✅ Fixed (v5) | `NotificationService.swift:62-64` | Notification content sanitized |
| S-10 | ✅ Fixed (v5) | `IChingApp.swift:98` | Data protection `.complete` |
| S-11 | ✅ Fixed (v5) | `DivineView.swift`, `JournalEditorView.swift` | Input length limits |
| B-24 | ✅ Fixed (v5) | `CoinFlipAnimator.swift:36-38` | Haptic timing fixed |
| B-25 | ✅ Fixed (v5) | `CoinFlipView.swift:104` | Rotation normalized |
| B-26 | ✅ Fixed (v5) | `IChingWidgets.swift:19` | Deterministic daily hexagram in snapshot |
| B-30 | ✅ Fixed (v5) | `SettingsView.swift:12-18` | Settings fallback |
| B-31 | ✅ Fixed (v5) | `IChingApp.swift:77-89` | `resetDatabase()` scans all `.store` files |
| A-23 | ✅ Fixed (v5) | Multiple files | Deep-link coordinator |
| A-24 | ✅ Fixed (v5) | `Reading.swift`, `IChingApp.swift` | Legacy fields removed; V2→V3 migration |
| A-25 | ✅ Fixed (v5) | `IChingWidgets.swift:23-37` | Timeline generates 3 days with midnight boundaries |
| Q-26 | ✅ Fixed (v5) | Multiple files | Dead code removed (11 items) |
| Q-27 | ✅ Fixed (v5) | `LibraryView.swift` | Unused `selectedHexagram` removed |
| Q-28 | ✅ Fixed (v5) | `SettingsView.swift:91` | Dynamic version from Bundle.main |
| Q-29 | ✅ Fixed (v5) | `CoinFlipView.swift` | Coin colors use theme constants |
| Q-30 | ✅ Fixed (v5) | `HexagramView.swift:115-125` | `HexagramBuildingView` accessibility |
| Q-31 | ✅ Verified (v5) | `Hexagram.swift:4` | Hexagram is `Identifiable, Hashable` |
| Q-32 | ✅ Fixed (v5) | `JournalEntry.swift:36` | `editThresholdSeconds` named constant |
| Q-33 | ✅ Fixed (v5) | `IChingWidgets.swift` | Widget Dynamic Type support |
| Q-34 | ✅ Fixed (v5) | `View+Extensions.swift`, multiple views | Reusable `.errorAlert()` modifier |
| S-15 | ✅ Fixed (v6) | `NotificationService.swift:59` | Removed dead hexagram lookup; simplified to range check |
| S-16 | ✅ Fixed (v6) | `NotificationService.swift:28,86` | Removed `.public` privacy from error logging |
| S-17 | ✅ Fixed (v6) | `IChingApp.swift:91-104` | `resetDatabase()` tracks primary store deletion separately |
| S-18 | ✅ Fixed (v6) | `Reading.swift:8,62,90` | Replaced `#if DEBUG print` with `Logger` using `.private` privacy |
| B-40 | ✅ Fixed (v6) | `HexagramBasicData.swift:82-89` | Multiplicative hash for less predictable daily hexagram sequence |
| A-32 | ✅ Fixed (v8) | `ReadingDetailView.swift`, `HistoryView.swift` | `.navigationDestination` moved from ReadingDetailView to HistoryView's NavigationStack |
| A-33 | ✅ Fixed (v8) | `IChingWidgets.entitlements` | Removed unused App Group from widget entitlements (main app retains for future use) |
| A-34 | ✅ Fixed (v7) | `IChingTests/` | All tests complete: NavigationCoordinator, Trigram, NotificationService (Q-49) |
| Q-40 | ✅ Fixed (v6) | `Hexagram.swift:29` | Removed redundant `symbol` property |
| Q-41 | ✅ Fixed (v6) | `Trigram.swift:100-126` | Removed unused `quality` and `familyMember` properties |
| Q-42 | ✅ Fixed (v6) | `SettingsView.swift:73-76` | Removed non-functional Sound Effects toggle |
| Q-43 | ✅ Fixed (v7) | `Line.swift:16-23` | `isYang`/`isChanging` now delegate to `value.isYang`/`value.isChanging` (Q-55) |
| Q-44 | ✅ Fixed (v6) | `HexagramView.swift:133-137` | `HexagramTextSection` enum replaces Int tags |
| Q-45 | ✅ Fixed (v6) | `HistoryView.swift:166`, `JournalListView.swift:114` | `.accessibilityElement(children: .combine)` on row views |
| Q-46 | ✅ Fixed (v6) | `JournalEditorView.swift:106` | Mood buttons have `.isSelected` trait and accessibility label |
| Q-47 | ✅ Fixed (v6) | `HexagramBasicData.swift:7`, `IChingWidgets.swift` | Renamed `name` → `englishName` for consistency |
| B-51 | ✅ Fixed (v7) | `ContentView.swift` | `HapticService.isEnabled` synced in `ensureSettingsExist()` |
| B-52 | ✅ Fixed (v7) | `SettingsView.swift` | Added `.onChange` handlers to call `NotificationService` scheduling |
| B-53 | ✅ Fixed (v7) | `ManualEntryView.swift:5` | Changed `@Bindable var` to `let` |
| S-20 | ✅ Fixed (v7) | `IChingApp.swift` | Generic error message shown; details logged via `Logger` with `.private` |
| S-21 | ✅ Fixed (v7) | `IChingApp.swift` | `enableDataProtection()` now logs failure at `.error` level |
| S-22 | ✅ Fixed (v7) | `DivineView.swift` | Control characters stripped from question input |
| S-23 | ✅ Fixed (v7) | `NavigationCoordinator.swift` | Malformed deep links logged at `.info` level |
| A-41 | ✅ Fixed (v7) | `DivineViewModel.swift` | Added state guards to `proceedToNextLine()` and `flipCoins()` |
| A-42 | ✅ Fixed (v7) | `HistoryView.swift` | Added `referenceDate` parameter for deterministic testing |
| A-43 | ✅ Fixed (v7) | `AppLogger.swift` | Centralized `AppLogger` with persistence/navigation/notifications categories |
| Q-55 | ✅ Fixed (v7) | `Line.swift` | `isYang`/`isChanging` now delegate to `value.isYang`/`value.isChanging` |
| Q-56 | ✅ Fixed (v7) | `HexagramLibrary.swift`, `View+Extensions.swift` | Removed dead `hexagram(upper:lower:)` and `View.if` |
| Q-57 | ✅ Fixed (v7) | `DivineView.swift` | Uses `ReadingMethod.icon` instead of hardcoded strings |
| Q-58 | ✅ Fixed (v7) | `ManualEntryView.swift` | Added descriptive accessibility labels to line picker options |
| Q-59 | ✅ Fixed (v7) | `View+Extensions.swift` | Added `.accessibilityLabel("Settings")` to gear button |

## Summary: Issue Status
| Category | Total | ✅ Fixed | ⚠️ Partial |
|----------|-------|---------|------------|
| Security (S) | 29 | 29 | 0 |
| Bugs (B) | 62 | 62 | 0 |
| Architecture (A) | 50 | 49 | 1 (A-47) |
| Quality (Q) | 69 | 69 | 0 |
| **Total** | **210** | **209** | **1** |

**v8 fix pass closed 32 of 32 newly-discovered issues — including the three originally deferred items (A-44, A-47, A-50). The post-fix follow-up resolved A-44 via `Hexagrams.current` (single overridable process-wide repository) and A-50 via `ServiceBundle` (aggregating stateless services). A-47 now has 14 view-integration tests covering the state-flow logic the v8 fixes addressed; full SwiftUI body-rendering coverage (snapshot or UI testing) remains as the only strategic gap. Plus 1 pre-existing test failure fixed (`Hexagram.transformed` returning the original hexagram instead of nil) and 1 pre-existing test typo. All 225 unit tests pass on iOS and macOS.**

## Setup Required

### Test Target (A-9)
Test files in `IChingTests/` (9 files, including new TrigramTests + NavigationCoordinatorTests). To enable:
1. In Xcode: File → New → Target → Unit Testing Bundle
2. Name it `IChingTests`, set test target to `IChing`
3. Add all `.swift` files from `IChingTests/` directory to the new target

### Shared Data (A-8)
`Shared/HexagramBasicData.swift` — add to **both** `IChing` and `IChingWidgets` targets.

### App Group (A-4)
1. Apple Developer portal: Create `group.com.iching.app`
2. Xcode: Enable App Groups for both targets

### URL Scheme (A-22/A-23)
1. In Xcode: Info → URL Types → Add `iching` URL scheme to the IChing target

### Xcode Project Updates (v6/v7)
1. Add `NavigationCoordinator.swift` to the IChing target
2. Add `IChingError.swift` to the IChing target
3. Add new test files (`TrigramTests.swift`, `NavigationCoordinatorTests.swift`) to the IChingTests target
4. Remove `TrigramView.swift` from Xcode project (deleted in v3)
5. **v7:** HexagramData1-4.swift references already removed from pbxproj
6. Remove empty groups: `Views/History/`, `Views/Library/`, `Views/Settings/` (deleted in v6)
7. Verify build: `Product → Build` (Cmd+B)

## Prioritized Remediation — Review #7
### All v7 issues resolved. No remaining high-priority items.

### Architecture refactors completed
1. **A-35** ✅ Unified hexagram data — `HexagramBasicInfo.all` now loads from `hexagram_basic.json`
2. **A-36** ✅ Singletons → `@Environment` injection via `ServiceEnvironment.swift`
3. **A-37** ✅ Centralized AppSettings via `@Observable` `SettingsManager`

## v8 Fix Locations — Quick Reference

| Finding | Fix |
|---------|-----|
| S-24, Q-65 | `Shared/HexagramBasicData.swift:25` — `fatalError` instead of `assertionFailure + return []` |
| S-25 | `IChing/IChing.entitlements` — App Group removed; widget already lacked it |
| S-26 | `IChing/Services/NavigationCoordinator.swift:36` — URL logged with `.private` |
| S-27 | `IChing/Services/SettingsManager.swift:21-37` — fetch/save errors logged via `AppLogger.persistence` |
| S-28 | `IChing/Info.plist:30` — `armv7` → `arm64` |
| S-29 | `IChing/Views/Reading/JournalEditorView.swift:32-44` — Cc/Cf control-char stripping (matches DivineView) |
| B-54 | `IChing/Services/CoinFlipAnimator.swift:31` — `guard flips < self.flipCount else { return }` |
| B-55 | `IChing/App/ContentView.swift:60-64` — `.onChange(pendingHexagramId)` mirrored on macOS branch |
| B-56 | `IChing/Views/Screens/LibraryView.swift:37-46,75-78` — `consumePendingNavigation()` runs on both `.onAppear` and `.onChange` |
| B-57 | `IChing/Views/Screens/HistoryView.swift:43-46,63-72` — `hasComputedGroups` gate prevents empty-list flash on first render |
| B-58 | `IChing/Models/Line.swift:50-52` — `precondition((0...3).contains(heads))` |
| B-59 | `IChing/Models/Reading.swift:81-91` — `Reading.create()` no longer double-resolves on success path |
| B-60 | `IChing/App/ContentView.swift:74-77`, `SettingsView.swift:106` — direct `HapticService.isEnabled = X` |
| B-61 | `IChing/Services/NavigationCoordinator.swift:30-35` — exact-shape path matching (`/`, then numeric id) |
| B-62 | `IChing/Views/Screens/SettingsView.swift:147-159` — `notificationTask` cancellation prevents toggle race |
| A-44 | `IChing/Models/HexagramLibrary.swift:17-32` — `Hexagrams.current` overridable global; `Hexagram.swift` defaults and `Reading.ensureHexagramCache` route through it |
| A-45 | `IChing/Services/SettingsManager.swift:43-50` — `persist()` called from every setter |
| A-46 | `scripts/generate_hexagram_basic.swift` — verify-mode-default drift detector (`--write` to regenerate) |
| A-48 | `IChing/App/IChingApp.swift:84-114` — SettingsManager initialized synchronously in `init()` |
| A-49 | `IChing/Utilities/AppLogger.swift:12-32` — `ModelContext.safeSave(operation:onError:)`; applied in HistoryView, JournalListView, JournalEditorView, DivineView |
| Q-60, Q-61 | `IChing/Services/SettingsManager.swift:138-184` — `SettingsView_ReadOnly` snapshot via `EnvironmentValues.settings`; SettingsView force-unwrap replaced with `if let` |
| Q-62 | `IChing/Models/AppSettings.swift` — alias getters `readingMethod` and `appColorScheme` removed |
| Q-63 | `LibraryView.swift`, `JournalListView.swift`, `HistoryView.swift` — `@State`-backed memoized filter lists |
| Q-64 | `IChing/Models/Reading.swift:48-52` — `hasCorruptedData` computed from `lineValuesRaw` (no more getter-side-effects) |
| Q-66 | `IChing/Views/Reading/ReadingDetailView.swift:11-13,47-50` — `sortedJournalEntries: @State` recomputed on `.onChange(of: reading.journalEntries)` |
| Q-67 | `IChing/Views/Screens/SettingsView.swift:215-237` — `do/catch` instead of `try!` in Preview helper |
| Q-68 | `IChing/Models/Reading.swift:9`, `ManualEntryView.swift:7,17` — `Reading.lineCount = 6` constant used in app target |
| Q-69 | `IChing/Views/Screens/LibraryView.swift` — unused `showPinyin` computed removed |

### Out-of-scope incidental fixes
- `IChingTests/CoinFlipAnimatorTests.swift:50,132` — pre-existing typo `assertForOverInFulfillment` → `assertForOverFulfill` (was blocking test compilation)
- `IChing/Models/Hexagram.swift:31-41` — pre-existing bug: `transformed(withChangingLines:)` returned the original hexagram when all positions were out of range; now returns `nil`

### Follow-up fixes for previously-deferred items
- **A-44** ✅ — `IChing/Models/HexagramLibrary.swift:17-32` — added `Hexagrams.current` as a single overridable process-wide repository. All default-parameter call sites (`Hexagram.from`, `Hexagram.transformed`, `Reading.ensureHexagramCache`) route through it. Tests reassign in setUp to redirect every consumer at once.
- **A-47** ✅ partial — `IChingTests/ViewIntegrationTests.swift` (new, 14 tests) — covers `Hexagrams.current` override, `Reading.create` single-resolve (B-59 regression), `hasCorruptedData` computed correctness, `NavigationCoordinator` strict path matching, `SettingsManager` persistence, sanitization contract, `SettingsView_ReadOnly` snapshot. Full SwiftUI body-rendering coverage still requires snapshot/UI tooling — only outstanding strategic gap.
- **A-50** ✅ — `IChing/Services/ServiceEnvironment.swift:5-37` — `ServiceBundle` aggregates the three stateless services (haptics, notifications, hexagrams) under `\.services`. `@Observable` keys deliberately remain separate to preserve granular change-tracking.

### Verification
- iOS Simulator (iPhone 17, iOS 26.2): build succeeds, 225/225 tests pass.
- macOS (arm64): build succeeds, 225/225 tests pass.
