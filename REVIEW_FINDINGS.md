# I Ching App — Review Findings
**Latest review:** 2026-03-16 (v1 / Review #1)
**Full report:** `docs/reviews/2026-03-16-full-review-v1.md`
**Rating:** 5.5 / 10 (pre-fix) → **8 / 10** (post-fix)

> **Legend:** ✅ Fixed | 🔴 Open-Critical | 🟠 Open-High | 🟡 Open-Medium | ⚪ Open-Low

## Critical — Fix Before Next Release
| ID | Status | File | Issue |
|----|--------|------|-------|
| B-1 | ✅ Fixed (v1) | `Line.swift:66-67` | Coin-flip mapping swaps youngYin/youngYang — every coin reading produces wrong hexagram |
| B-2 | ✅ Fixed (v1) | `IChingApp.swift` | `fatalError` on ModelContainer init failure — replaced with graceful error view |
| B-3 | ✅ Fixed (v1) | `DivineViewModel.swift:4` | Timer mutates @Observable off main thread — added @MainActor + uses HapticService |
| S-1 | ✅ Fixed (v1) | `NotificationService.swift:45` | Force unwrap `hexagram(number:)!` — replaced with guard let |

## High Priority — Next Sprint
| ID | Status | File | Issue |
|----|--------|------|-------|
| B-4 | ✅ Fixed (v1) | `IChingWidgets.swift:31-94` | Widget only has 11 of 64 hexagrams — now has all 64 |
| B-5 | ✅ Fixed (v1) | `HistoryView.swift:45` | Operator precedence bug in sort — added parentheses |
| A-1 | ✅ Fixed (v1) | `Color+Theme.swift:14-22` | iOS-only UIColor names won't compile for macOS — added #if os(macOS) guards |
| S-2 | 🟠 | `IChingApp.swift:19` | CloudKit syncs journal entries (personal reflections) unencrypted |
| S-3 | ✅ Fixed (v1) | `IChing.entitlements` | Unnecessary `network.client` entitlement — removed |

## Medium Priority — Sprint After
| ID | Status | File | Issue |
|----|--------|------|-------|
| B-6 | ✅ Fixed (v1) | `Reading.swift:68-71` | `compactMap` silently drops corrupted lineValues — replaced with map + default |
| B-7 | ✅ Fixed (v1) | `SettingsView.swift` | Side effect in computed property — moved insert to .onAppear |
| B-8 | ✅ Fixed (v1) | `JournalEntry.swift:26` | `update()` overwrites mood with nil — removed default parameter |
| B-9 | ✅ Fixed (v1) | `IChingWidgets.swift:68` | Force unwrap on `calendar.date(byAdding:)!` — added fallback |
| A-2 | 🟡 | `HexagramLibrary.swift` | Singleton tightly coupled — no dependency injection, untestable |
| A-3 | 🟡 | `DivineViewModel.swift` | Mixes UI concerns (animation/haptics) with domain logic |
| A-4 | 🟡 | `IChingWidgets.swift` | Widget duplicates hexagram data — no shared App Group |
| A-5 | 🟡 | `AppSettings.swift` | No uniqueness enforcement — multiple settings objects possible |
| Q-1 | ✅ Fixed (v1) | `CoinFlipView.swift` | No VoiceOver accessibility — added labels and hints |
| Q-2 | ✅ Fixed (v1) | `DivineView.swift:53` | Hardcoded font sizes — replaced with .largeTitle for Dynamic Type |
| Q-3 | ✅ Fixed (v1) | `DivineViewModel.swift` | Bypasses HapticService — now uses HapticService.impact/notification |

## Low Priority
| ID | Status | File | Issue |
|----|--------|------|-------|
| S-4 | ✅ Fixed (v1) | `Info.plist` | Unused `fetch` background mode — removed |
| S-5 | ⚪ | `JournalEntry.swift` | SwiftData store not encrypted on disk |
| S-6 | ⚪ | `NotificationService.swift:53` | Notification userInfo exposes internal IDs |
| B-10 | ⚪ | `Reading.swift:61-64` | Failed hexagram lookup silently defaults to #1 |
| A-6 | ⚪ | `NotificationService.swift:6-9` | @Observable singleton — unusual pattern, re-render risk |
| A-7 | ⚪ | Views lack dependency injection — not testable |
| Q-4 | ✅ Fixed (v1) | `DateFormatters.swift:26-28` | `monthYear` format not locale-aware — uses setLocalizedDateFormatFromTemplate |
| Q-5 | ✅ Fixed (v1) | `HexagramLibrary.swift:16-23` | O(n) lookup — now O(1) with array index + fallback |
| Q-6 | ✅ Fixed (v1) | `Reading.swift:102-115` | DateFormatter per access — now uses cached DateFormatters |
| Q-7 | ✅ Fixed (v1) | `Hexagram.swift:29-31` | Dead `baseCodePoint` variable — removed |
| Q-8 | ⚪ | `Color+Theme.swift:8-11` | Semantic colors all map to identical values |
| Q-9 | ⚪ | `Hexagram.swift` | Missing explicit Hashable — synthesized version hashes large text |

## Summary: Issue Status
| Category | Total | ✅ Fixed | 🟠 Open-High | 🟡 Open-Medium | ⚪ Open-Low |
|----------|-------|---------|-------------|--------------|------------|
| Security (S) | 6 | 3 | 1 | 0 | 2 |
| Bugs (B) | 10 | 8 | 0 | 0 | 1 |
| Architecture (A) | 7 | 1 | 0 | 4 | 2 |
| Quality (Q) | 9 | 6 | 0 | 0 | 2 |
| **Total** | **32** | **18** | **1** | **4** | **7** |

## Remaining Open Issues
### High (1)
- **S-2** — CloudKit encryption for journal entries. Requires evaluating `NSFileProtection` or encrypting sensitive fields before sync.

### Medium (4) — Architectural improvements
- **A-2** — Extract `HexagramLibrary` protocol for testability
- **A-3** — Separate animation/haptic concerns from `DivineViewModel`
- **A-4** — Share hexagram data between app and widget via App Group
- **A-5** — Add uniqueness constraint to `AppSettings` model

### Low (7) — Minor quality items
- **S-5** — On-disk encryption for SwiftData store
- **S-6** — Notification userInfo leaks internal IDs
- **B-10** — Silent default to Hexagram 1 on corruption
- **A-6/A-7** — Singleton pattern and DI concerns
- **Q-8/Q-9** — Color semantics and Hashable conformance
