# I Ching App — Review Findings
**Latest review:** 2026-03-25 (v7 / Review #7)
**Full report:** `docs/reviews/2026-03-25-full-review-v7.md`
**Rating:** 5.5 / 10 (v1 pre-fix) → 8 / 10 (v1 post-fix) → 6.5 / 10 (v2 pre-fix) → 9 / 10 (v2 post-fix) → 7.5 / 10 (v3 pre-fix) → 9.5 / 10 (v3 post-fix) → 8 / 10 (v4 pre-fix) → 9.5 / 10 (v5 post-fix) → 7.5 / 10 (v6 pre-fix) → 9.5 / 10 (v6 post-fix) → 8 / 10 (v7 pre-fix) → **9.5 / 10** (v7 post-fix)

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
| Category | Total | ✅ Fixed | 🟠 Deferred-High | ⚪ Deferred |
|----------|-------|---------|-------------------|-------------|
| Security (S) | 23 | 23 | 0 | 0 |
| Bugs (B) | 53 | 53 | 0 | 0 |
| Architecture (A) | 43 | 43 | 0 | 0 |
| Quality (Q) | 59 | 59 | 0 | 0 |
| **Total** | **178** | **178** | **0** | **0** |

**All 178 issues resolved across 8 reviews. 0 deferred.**

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
