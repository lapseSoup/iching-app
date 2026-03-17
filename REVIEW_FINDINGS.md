# I Ching App — Review Findings
**Latest review:** 2026-03-17 (v2 / Review #2)
**Full report:** `docs/reviews/2026-03-17-full-review-v2.md`
**Rating:** 5.5 / 10 (v1 pre-fix) → 8 / 10 (v1 post-fix) → 6.5 / 10 (v2 pre-fix) → **9 / 10** (v2 post-fix — all issues resolved)

> **Legend:** ✅ Fixed | 🔴 Open-Critical | 🟠 Open-High | 🟡 Open-Medium | ⚪ Open-Low

## Critical — Fix Before Next Release
| ID | Status | File | Issue |
|----|--------|------|-------|
| B-1 | ✅ Fixed (v1) | `Line.swift:66-67` | Coin-flip mapping swaps youngYin/youngYang — every coin reading produces wrong hexagram |
| B-2 | ✅ Fixed (v1) | `IChingApp.swift` | `fatalError` on ModelContainer init failure — replaced with graceful error view |
| B-3 | ✅ Fixed (v1) | `DivineViewModel.swift:4` | Timer mutates @Observable off main thread — added @MainActor + uses HapticService |
| S-1 | ✅ Fixed (v1) | `NotificationService.swift:45` | Force unwrap `hexagram(number:)!` — replaced with guard let |
| B-11 | ✅ Fixed (v2) | `DivineViewModel.swift` | Timer retain cycle — extracted to `CoinFlipAnimator` service with `[weak self]` and proper cleanup |

## High Priority — Next Sprint
| ID | Status | File | Issue |
|----|--------|------|-------|
| B-4 | ✅ Fixed (v1) | `IChingWidgets.swift:31-94` | Widget only has 11 of 64 hexagrams — now has all 64 |
| B-5 | ✅ Fixed (v1) | `HistoryView.swift:45` | Operator precedence bug in sort — added parentheses |
| A-1 | ✅ Fixed (v1) | `Color+Theme.swift:14-22` | iOS-only UIColor names won't compile for macOS — added #if os(macOS) guards |
| S-2 | ✅ Fixed (v2) | `IChingApp.swift:20` | CloudKit syncs unencrypted — changed to `.none` default, added iCloudSyncEnabled toggle in Settings |
| S-3 | ✅ Fixed (v1) | `IChing.entitlements` | Unnecessary `network.client` entitlement — removed |
| B-12 | ✅ Fixed (v2) | `Reading.swift:68-71` | Silent data corruption — added enumerated logging for invalid rawValues |
| A-8 | ✅ Fixed (v2) | `Shared/HexagramBasicData.swift` | Created shared `HexagramBasicInfo` single source of truth for both app and widget |
| A-9 | ✅ Fixed (v2) | `IChingTests/` | Created test suite: LineValueTests, HexagramLibraryTests, HexagramTests, HexagramBasicDataTests |

## Medium Priority — Sprint After
| ID | Status | File | Issue |
|----|--------|------|-------|
| B-6 | ✅ Fixed (v1) | `Reading.swift:68-71` | `compactMap` silently drops corrupted lineValues — replaced with map + default |
| B-7 | ✅ Fixed (v1) | `SettingsView.swift` | Side effect in computed property — moved insert to .onAppear |
| B-8 | ✅ Fixed (v1) | `JournalEntry.swift:26` | `update()` overwrites mood with nil — removed default parameter |
| B-9 | ✅ Fixed (v1) | `IChingWidgets.swift:68` | Force unwrap on `calendar.date(byAdding:)!` — added fallback |
| A-2 | ✅ Fixed (v2) | `HexagramLibrary.swift` | Extracted `HexagramRepository` protocol for dependency injection and testability |
| A-3 | ✅ Fixed (v2) | `CoinFlipAnimator.swift` | Extracted timer/haptic animation into dedicated `CoinFlipAnimator` service |
| A-4 | ✅ Fixed (v2) | `IChing.entitlements` + `IChingWidgets.entitlements` | Added `group.com.iching.app` App Group to both targets |
| A-5 | ✅ Fixed (v2) | `AppSettings.swift` | Added `#if swift(>=6.0) @Attribute(.unique)` on id field |
| Q-1 | ✅ Fixed (v1) | `CoinFlipView.swift` | No VoiceOver accessibility — added labels and hints |
| Q-2 | ✅ Fixed (v1) | `DivineView.swift:53` | Hardcoded font sizes — replaced with .largeTitle for Dynamic Type |
| Q-3 | ✅ Fixed (v1) | `DivineViewModel.swift` | Bypasses HapticService — now uses HapticService.impact/notification |
| S-7 | ✅ Fixed (v2) | `NotificationService.swift` | Replaced `print()` with `os.log` Logger with privacy annotations |
| S-8 | ✅ Fixed (v2) | `Info.plist` | Removed unused `remote-notification` background mode |
| A-10 | ✅ Fixed (v2) | `IChingApp.swift` | Added `IChingSchemaV1/V2` + `IChingMigrationPlan` with lightweight migration |
| A-11 | ✅ Fixed (v2) | `Reading.swift:25` | Changed `.cascade` to `.nullify` — journal entries survive reading deletion |
| B-13 | ✅ Fixed (v2) | `NotificationService.swift` + `IChingWidgets.swift` | Both now use `HexagramBasicInfo.dailyHexagramId(for:)` shared algorithm |
| Q-10 | ✅ Fixed (v2) | `LibraryView.swift`, `DivineView.swift` | Added accessibility labels to hexagram cards and method buttons |
| Q-11 | ✅ Fixed (v2) | `AppSettings.swift` | Added `AppColorScheme` enum with `appColorScheme` computed property |
| Q-12 | ✅ Fixed (v2) | `NotificationService.swift`, `ReadingDetailView.swift` | Extracted magic strings to constants, uses `LineValue.changingSymbol` |

## Low Priority
| ID | Status | File | Issue |
|----|--------|------|-------|
| S-4 | ✅ Fixed (v1) | `Info.plist` | Unused `fetch` background mode — removed |
| S-5 | ✅ Fixed (v2) | `IChingApp.swift` | Added `NSFileProtection.completeUntilFirstUserAuthentication` on data store |
| S-6 | ✅ Fixed (v2) | `NotificationService.swift` | Removed hexagramId from notification userInfo |
| B-10 | ✅ Fixed (v2) | `Reading.swift:57-64` | Added `#if DEBUG` warning log when hexagram lookup defaults to #1 |
| A-6 | ✅ Fixed (v2) | `NotificationService.swift` | Added `@MainActor` isolation to ensure thread-safe `isAuthorized` mutations |
| A-7 | ✅ Fixed (v2) | `DivineView.swift` | Added `init(viewModel:)` for dependency injection and testability |
| Q-4 | ✅ Fixed (v1) | `DateFormatters.swift:26-28` | `monthYear` format not locale-aware — uses setLocalizedDateFormatFromTemplate |
| Q-5 | ✅ Fixed (v1) | `HexagramLibrary.swift:16-23` | O(n) lookup — now O(1) with array index + fallback |
| Q-6 | ✅ Fixed (v1) | `Reading.swift:102-115` | DateFormatter per access — now uses cached DateFormatters |
| Q-7 | ✅ Fixed (v1) | `Hexagram.swift:29-31` | Dead `baseCodePoint` variable — removed |
| Q-8 | ✅ Fixed (v2) | `Color+Theme.swift:8-11` | Yang/yin now use distinct colors (`.primary`/`.secondary`, `.orange`/`.purple`) |
| Q-9 | ✅ Fixed (v2) | `Hexagram.swift` | Added explicit `hash(into:)` that only hashes `id` |
| A-12 | ✅ Fixed (v2) | `Reading.swift` | Added `lineValuesRaw: [Int]` array with fallback to legacy fields; V1→V2 migration |
| Q-13 | ✅ Fixed (v2) | `Reading.swift` | Added `@Transient` cached hexagram lookups with `ensureHexagramCache()` |
| Q-14 | ✅ Fixed (v2) | `DateFormatters.swift` | Removed unused `relative` formatter and `relativeFormatted` extension |
| Q-15 | ✅ Fixed (v2) | `View+Extensions.swift` | Removed unused `hideKeyboard()` method |

## Summary: Issue Status
| Category | Total | ✅ Fixed |
|----------|-------|---------|
| Security (S) | 8 | 8 |
| Bugs (B) | 13 | 13 |
| Architecture (A) | 12 | 12 |
| Quality (Q) | 15 | 15 |
| **Total** | **48** | **48** |

**All issues resolved. 0 open.**

## Setup Required

### Test Target (A-9)
Test files created in `IChingTests/`. To enable:
1. In Xcode: File → New → Target → Unit Testing Bundle
2. Name it `IChingTests`, set test target to `IChing`
3. Add the 4 test files from `IChingTests/` directory to the new target

### Shared Data (A-8)
`Shared/HexagramBasicData.swift` created as single source of truth.
1. In Xcode: Add `Shared/HexagramBasicData.swift` to **both** the `IChing` and `IChingWidgets` targets

### App Group (A-4)
Entitlements files updated with `group.com.iching.app`.
1. In Apple Developer portal: Create App Group `group.com.iching.app`
2. In Xcode: Enable App Groups capability for both targets and select the group

### Widget Entitlements (A-4)
1. In Xcode: Set `IChingWidgets/IChingWidgets.entitlements` as the entitlements file for the widget target
