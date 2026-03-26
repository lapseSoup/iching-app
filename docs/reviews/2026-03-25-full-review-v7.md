# I Ching App — Full Code Review v7

**Date:** 2026-03-25
**Reviewer:** Claude Opus 4.6 (automated)
**Build status:** Passes after removing stale HexagramData1-4 pbxproj references
**Compiler warnings:** 1 (NavigationCoordinator protocol conformance — Swift 6 error)

---

## Pre-Review Fix

The project failed to build because `HexagramData1-4.swift` files were deleted in v6 but their references remained in `project.pbxproj`. Removed 16 stale references across PBXBuildFile, PBXFileReference, PBXGroup, and PBXSourcesBuildPhase sections. Build now succeeds.

---

## Phase 1: Security Audit

The app has zero network surface, no secrets, minimal entitlements, and proper data protection. No critical or high security issues found.

### S-19 — Missing `modelContext.rollback()` on delete failure (Medium)
**Files:** `HistoryView.swift:108`, `JournalListView.swift:70`
When `modelContext.save()` throws after a delete, the in-memory deletions persist in the context, leaving it inconsistent. `JournalEditorView` correctly calls `rollback()` in this scenario, but these two views do not.
**Fix:** Add `modelContext.rollback()` in catch blocks.

### S-20 — Error view exposes raw `localizedDescription` (Low)
**File:** `IChingApp.swift:153`
The error fallback view displays `initError` directly, which could contain internal paths or schema details from SwiftData failures.
**Fix:** Show a generic message; log details via `os.log` with `.private`.

### S-21 — `enableDataProtection()` silently swallows failure (Low)
**File:** `IChingApp.swift:119-126`
Uses `try?` — if file protection fails, no diagnostic is logged.
**Fix:** Log at `.error` level.

### S-22 — No control character sanitization on question input (Low)
**File:** `DivineView.swift:91`
The 500-char limit is enforced but Unicode control characters (Cc/Cf) could cause layout issues.
**Fix:** Strip control characters before save.

### S-23 — Malformed deep links silently resolve (Low)
**File:** `NavigationCoordinator.swift:29`
`iching://daily/anything` resolves to today's hexagram. Not exploitable, but masks construction errors.
**Fix:** Log malformed URLs at `.info` level.

---

## Phase 2: Bug Detection

### B-41 — SettingsView orphan AppSettings on fallback (High)
**File:** `SettingsView.swift:10`
`settingsArray.first ?? AppSettings()` creates an un-inserted instance. Mutations to this throwaway object are silently lost if `@Query` hasn't resolved yet.
**Fix:** Guard with a loading state, or insert the fallback into the context.

### B-42 — NavigationCoordinating protocol breaks Swift 6 (High)
**File:** `NavigationCoordinator.swift:13`
Non-isolated protocol with `@MainActor` conformer is a compiler warning now, hard error in Swift 6.
**Fix:** Add `@MainActor` to the protocol declaration.

### B-43 — CoinFlipAnimator.assumeIsolated in Timer — trap risk (High)
**File:** `CoinFlipAnimator.swift:21`
`MainActor.assumeIsolated` is a runtime assertion. If the timer fires off-main-thread, the app crashes.
**Fix:** Use `Task { @MainActor in ... }` or migrate to async timer.

### B-44 — CoinFlipAnimator.deinit accesses @MainActor property (High)
**File:** `CoinFlipAnimator.swift:51`
`deinit` is non-isolated but calls `timer?.invalidate()` on a `@MainActor`-isolated property. Swift 6 error; potential race today.
**Fix:** Remove `deinit` (stop() handles cleanup), or dispatch to MainActor.

### B-45 — Deep-link race in LibraryView (Medium)
**File:** `LibraryView.swift:52-64`
Both `.onAppear` and `.onChange` consume `pendingHexagramId`. Double consumption can nil out a valid hexagram.
**Fix:** Use single consumption path via `consumePendingHexagram()` only.

### B-46 — Dual navigationDestination for Hexagram type (Medium)
**File:** `LibraryView.swift:46-51`
Two `navigationDestination` modifiers for `Hexagram` — ambiguous routing.
**Fix:** Use a single `navigationDestination(for:)` with path manipulation.

### B-47 — No dismiss() after journal entry deletion (Medium)
**File:** `JournalEditorView.swift:221`
Successful deletion leaves the deleted entry's detail view on screen.
**Fix:** Call `dismiss()` after successful save.

### B-48 — dailyHexagramId signed arithmetic overflow risk (Medium)
**File:** `HexagramBasicData.swift:88`
`abs(h % 64)` can overflow if `h == Int.min`. Signed modulo preserves sign.
**Fix:** Use `((h % 64) + 64) % 64 + 1` or switch to unsigned arithmetic.

### B-49 — Reading.lineValues silently masks corruption (Medium)
**File:** `Reading.swift:88-96`
Invalid raw values default to `.youngYang` with no UI indication.
**Fix:** Surface corruption via a transient flag or result type.

### B-50 — No lineValuesRaw count validation on load (Medium)
**File:** `Reading.swift:19`
If the database contains != 6 elements, downstream array access crashes.
**Fix:** Add bounds checking in `lines` and `changingLinePositions`.

### B-51 — HapticService.isEnabled not synced on launch (Low)
**File:** `HapticService.swift:8`
Defaults to `true`; only synced when user opens Settings.
**Fix:** Sync in `ContentView.ensureSettingsExist()`.

### B-52 — Daily notification toggle is non-functional (Low)
**File:** `SettingsView.swift`
Toggle changes the setting but never calls `NotificationService` scheduling methods.
**Fix:** Add `.onChange` handlers for the toggle and time picker.

### B-53 — Unnecessary @Bindable in ManualEntryView (Low)
**File:** `ManualEntryView.swift:5`
No bindings are created; `let` would suffice.
**Fix:** Change `@Bindable var` to `let`.

---

## Phase 3: Architecture Review

### A-35 — Dual hexagram data sources — drift risk (High)
**Files:** `HexagramBasicData.swift` + `hexagrams.json`
Two independent sources must be kept in sync manually. Test validates consistency but doesn't prevent drift.
**Fix:** Single shared JSON with lightweight loader for both targets.

### A-36 — Singleton-heavy architecture limits testability (High)
**Files:** `NavigationCoordinator.swift:14`, `NotificationService.swift:11`, `HexagramLibrary.swift:58`, `HapticService.swift:6`
Four services use static singletons, accessed directly in views.
**Fix:** Inject via SwiftUI `@Environment` with custom keys.

### A-37 — AppSettings @Query pattern is fragile (High)
**Files:** Multiple views
Every view runs its own `@Query` for the singleton row. Fallback creates orphan objects.
**Fix:** Load once at app root, pass via `@Environment`.

### A-38 — No SwiftData error recovery beyond alerts (Medium)
**Files:** Multiple views
No retry, no rollback (inconsistent), no logging on persistence failures.
**Fix:** Standardize into a persistence error handling service.

### A-39 — Widget App Group declared but unused (Medium)
**File:** `IChing.entitlements`
`group.com.iching.app` exists but nothing uses it.
**Fix:** Remove or implement shared storage.

### A-40 — Reading model mixes concerns (Medium)
**File:** `Reading.swift`
Persistence, domain logic, caching, and presentation in one class.
**Fix:** Extract formatting to extension, hexagram resolution to service.

### A-41 — DivineViewModel lacks state transition guards (Low)
**File:** `DivineViewModel.swift`
`proceedToNextLine()` callable from any state including `.idle`.
**Fix:** Add state guards.

### A-42 — groupReadingsByDate is untestable free function (Low)
**File:** `HistoryView.swift:6-31`
Top-level function with internal `Date()` — non-deterministic.
**Fix:** Move to utility type, accept reference date parameter.

### A-43 — No structured logging strategy (Low)
Only `Reading` and `NotificationService` define loggers. All other error paths are silent.
**Fix:** Centralized logging utility with instrumentation on all error paths.

---

## Phase 4: Code Quality

### Q-48 — No tests for CoinFlipAnimator (High)
**File:** `CoinFlipAnimator.swift`
Core interaction component with zero test coverage.
**Fix:** Add lifecycle, callback, and timing tests.

### Q-49 — No tests for NotificationService (High)
**File:** `NotificationService.swift`
Scheduling logic is complex and untested.
**Fix:** Extract date logic into pure functions and unit test.

### Q-50 — Reading.lines recomputes on every access (Medium)
**File:** `Reading.swift:99-113`
Creates new Line objects with new UUIDs each time. Multiple accesses per view body.
**Fix:** Cache in `@Transient` properties.

### Q-51 — HistoryView.groupedReadings recomputes every render (Medium)
**File:** `HistoryView.swift:55-57`
Dictionary grouping + sorting on every body evaluation.
**Fix:** Memoize via `@State` + `.onChange`.

### Q-52 — HexagramCard queries settings individually (64x) (Medium)
**File:** `LibraryView.swift:72`
Each card in the 64-cell grid runs its own `@Query`.
**Fix:** Pass settings as parameters from parent.

### Q-53 — Duplicated hexagram header card pattern (Medium)
**Files:** `ReadingDetailView.swift:67-96`, `HexagramDetailView.swift:37-69`
Nearly identical header rendering.
**Fix:** Extract `HexagramHeaderCard` component.

### Q-54 — ReadingRow/JournalEntryRow accessibility labels unstructured (Medium)
**Files:** `HistoryView.swift:118-168`, `JournalListView.swift:78-116`
`.combine` produces unpredictable VoiceOver output.
**Fix:** Add explicit `.accessibilityLabel()` with structured text.

### Q-55 — Line.isYang reimplements instead of delegating (Low)
**File:** `Line.swift:16-23`
`Line.isYang` duplicates `LineValue.isYang` logic instead of calling it.
**Fix:** Delegate: `var isYang: Bool { value.isYang }`.

### Q-56 — Dead code: hexagram(upper:lower:) and View.if (Low)
**Files:** `HexagramLibrary.swift:104-107`, `View+Extensions.swift:5-12`
Defined but never called.
**Fix:** Remove or document as public API.

### Q-57 — DivineView hardcodes method icons (Low)
**File:** `DivineView.swift:106-109`
Uses string literals instead of `ReadingMethod.icon`.
**Fix:** Use the existing `.icon` property.

### Q-58 — ManualEntryView line picker accessibility (Low)
**File:** `ManualEntryView.swift:60-67`
Unicode line symbols may confuse VoiceOver.
**Fix:** Add descriptive `.accessibilityLabel()` per option.

### Q-59 — Settings toolbar gear button lacks label (Low)
**File:** `View+Extensions.swift:15-31`
May read as "gearshape" instead of "Settings".
**Fix:** Add `.accessibilityLabel("Settings")`.

---

## Overall Health Rating: 8 / 10

The codebase has matured significantly through 6 prior reviews (131/139 issues resolved). The main gaps now are:
1. **Swift 6 readiness** — protocol isolation and timer concurrency patterns
2. **Settings singleton fragility** — orphan object risk
3. **Missing service tests** — CoinFlipAnimator and NotificationService
4. **Non-functional daily notifications** — toggle wired to setting but not to scheduler

The app is solid for its scope with no exploitable security issues, good model-level test coverage, and clean separation of concerns. The issues found are primarily about robustness, future-proofing, and filling test gaps.
