# I Ching App — Full Review v6
**Date:** 2026-03-23
**Reviewer:** Claude Code (automated)
**Rating:** 7.5 / 10 (pre-fix)
**Codebase:** ~8,700 lines across 46 Swift files

## Executive Summary

This is the sixth review of the I Ching iOS/macOS app. All 102 issues from reviews 1-5 have been confirmed fixed. This review found **38 new issues**: 6 high priority, 16 medium, and 16 low. The codebase is well-structured with good architectural foundations (protocol-based DI, failable initializers, error boundaries, schema versioning), but shows signs of feature drift (settings that don't work), dead code accumulation, and gaps in Swift 6 concurrency readiness.

**Top 3 themes:**
1. **Notification/widget timing edge cases** — DST transitions and past-time scheduling
2. **Settings that toggle but don't do anything** — `showChineseCharacters`, `showPinyin`, `soundEffectsEnabled`
3. **Swift 6 concurrency readiness** — Timer callbacks crossing actor boundaries

---

## Phase 1: Security Audit

The app's security posture remains strong. No network calls, no hardcoded secrets, file protection set to `.complete`, URL scheme properly validated, notification content sanitized.

### S-13 [Medium] — Journal deletion missing save()
`JournalListView.swift:64-67` calls `modelContext.delete()` without `try modelContext.save()`. Every other delete path in the app (HistoryView, JournalEditorView, DivineView) explicitly saves with error handling. If the app crashes or is force-quit before SwiftData's autosave triggers, the deletion is lost. This is also a consistency issue — the pattern was established in v5 (Q-22) but this one was missed.

### S-14 [Medium] — Unused CloudKit entitlements
`IChing.entitlements` declares CloudKit container, iCloud services, and ubiquity KVS entitlements, but the app explicitly uses `cloudKitDatabase: .none` and the iCloud sync UI shows "Coming Soon". These entitlements grant unnecessary capabilities per the principle of least privilege.

### S-15–S-18 [Low] — Minor hygiene items
Dead hexagram lookup in notification scheduling (S-15), `.public` log privacy (S-16), silent deletion failures in `resetDatabase()` (S-17), and debug-only console prints (S-18). None are exploitable but all are worth cleaning up.

---

## Phase 2: Bug Detection

Nine actionable bugs found, three at high severity.

### B-32 [High] — Widget DST inconsistency
The widget timeline provider uses raw `Date()` for today's entry but `calendar.startOfDay(for:)` for future days. During DST transitions, `dailyHexagramId(for:)` could return different values for the same calendar day depending on the time component. Fix: normalize all dates to `startOfDay` before passing to the algorithm.

### B-33 [High] — Past notification silently lost
When `scheduleDailyHexagram()` runs after the configured notification time (e.g., user opens app at 3 PM but notification is set for 8 AM), today's notification is scheduled with date components in the past. `UNCalendarNotificationTrigger` with `repeats: false` silently discards past-time triggers. The user gets no notification until tomorrow. Fix: skip `dayOffset == 0` if the target time has passed.

### B-34 [High] — Settings duplication race
`SettingsView.settings` is a computed property that inserts a new `AppSettings` into the model context every time it's called when `settingsArray` is empty. This races with `ContentView.ensureSettingsExist()`. While `@Attribute(.unique)` deduplicates, the returned local instance may not be the persisted singleton, causing mutations to not propagate. Fix: return `settingsArray.first` without inserting; rely on `ContentView` as the single insertion point.

### B-35–B-39 [Medium] — Concurrency, validation, and robustness
- **B-35**: `CoinFlipAnimator`'s Timer callback accesses `@MainActor` properties from a `@Sendable` closure — a Swift 6 data race.
- **B-36**: `Reading.init` accepts arbitrary line counts without validation.
- **B-37**: Edit button in `JournalEditorView` does nothing when `entry.reading` is nil.
- **B-38**: Malformed deep link URLs are silently ignored instead of falling back to the daily hexagram.
- **B-39**: `DivineViewModel.hexagramResult` recomputes on every property access — should be cached.

### B-40 [Low] — Predictable daily hexagram
`(day % 64) + 1` produces a sequential cycle (1, 2, 3, ..., 64) rather than a pseudo-random distribution. Users who check daily will notice the pattern.

---

## Phase 3: Architecture Review

The architecture is solid for a single-developer project. The main gaps are DI consistency and dead code bulk.

### A-26 [High] — Reading bypasses DI for hexagram cache
`Reading.ensureHexagramCache()` directly accesses `HexagramLibrary.shared`, even though `Hexagram.from()` and `Hexagram.transformed()` already accept a `HexagramRepository` parameter. This makes Reading's hexagram resolution untestable in isolation. Fix: accept an optional `HexagramRepository` as a `@Transient` property.

### A-27 [Medium] — 2,400 lines of redundant fallback data
`HexagramData1-4.swift` contain hardcoded hexagram definitions as a fallback if JSON loading fails. The JSON has been the primary source since v2 and is a bundled resource — if it's missing, the app has a broken build, not a runtime issue. These 2,400 lines inflate compile time and binary size with no real safety benefit.

### A-28–A-31 [Medium] — Schema docs, DI gaps, testability
- **A-28**: Schema V1/V2/V3 all reference identical model arrays with no documentation of what changed between versions.
- **A-29**: `NavigationCoordinator` uses `.shared` singleton without protocol abstraction (unlike `HexagramLibrary` which has `HexagramRepository`).
- **A-30**: `HapticService.isEnabled` is a non-thread-safe global static without `@MainActor`.
- **A-31**: `HistoryView.groupedReadings` contains non-trivial grouping/sorting logic that's untestable without rendering the view.

### A-32–A-34 [Low] — Navigation fragility, unused App Groups, missing service tests.

---

## Phase 4: Code Quality

### Q-35 [Medium] — Settings toggles that do nothing
`showChineseCharacters` and `showPinyin` in `AppSettings` are toggled in the Settings UI, but no view reads them. Users see working toggles with zero effect — a UX defect that undermines trust in the settings screen.

### Q-36 [Medium] — String-typed settings
`colorScheme` and `defaultReadingMethod` are stored as `String` with computed property wrappers parsing back to enums. Since SwiftData supports enum Codable conformance (proven by `Mood` on `JournalEntry`), these should be stored as typed enums directly.

### Q-37 [Medium] — Dead code
`Line.transformedIsYang` and `Line.displaySymbol` are defined but never referenced. Several `Trigram` properties (`quality`, `familyMember`, `pinyin`) are similarly unused.

### Q-38 [Medium] — Widget line rendering duplication
`WidgetLineView` duplicates the rendering logic from `LineView`. Moving `LineView` to the Shared target would enable reuse.

### Q-39 [Medium] — Test coverage gaps
No tests for `Trigram.from(lines:)`, `Trigram.from(name:)`, or `NavigationCoordinator.handle(url:)`. These contain branching logic that should be verified.

### Q-40–Q-47 [Low] — Dead properties, trivial wrappers, accessibility gaps, naming inconsistencies.

---

## Codebase Statistics

| Metric | Value |
|--------|-------|
| Total Swift files | 46 |
| Total lines of code | ~8,700 |
| Main app code | ~5,900 lines |
| Test code | ~1,340 lines |
| Widget code | ~190 lines |
| Shared code | ~90 lines |
| Test files | 7 |
| Total tests | ~96 (estimated from test file analysis) |
| JSON data | ~2,800 lines (hexagrams.json) |
| Hardcoded fallback | ~2,400 lines (HexagramData1-4.swift) |

## Rating Breakdown

| Dimension | Score | Notes |
|-----------|-------|-------|
| Security | 9/10 | No network calls, good file protection, minor entitlement cleanup needed |
| Correctness | 7/10 | Notification/widget timing bugs, settings race, dead toggles |
| Architecture | 7.5/10 | Good patterns established but DI not fully consistent |
| Code Quality | 7/10 | Dead code accumulation, missing tests for services |
| **Overall** | **7.5/10** | Solid foundation, needs a cleanup pass |

## Remediation Effort Estimate

| Priority | Count | Effort |
|----------|-------|--------|
| Quick fixes (high priority) | 6 | ~2 hours |
| Medium effort (next sprint) | 9 | ~4 hours |
| Cleanup (sprint after) | 7+ | ~3 hours |
| Low priority | 16 | As time permits |
