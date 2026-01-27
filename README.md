# 易經 (I Ching) - The Book of Changes

A premium iOS/macOS divination app built with SwiftUI, offering an authentic I Ching consultation experience with beautiful design and complete interpretations.

![Platform](https://img.shields.io/badge/Platform-iOS%2017%2B%20%7C%20macOS%2014%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![SwiftUI](https://img.shields.io/badge/SwiftUI-✓-green)

## Features

### 🎲 Divination Methods
- **Animated Coin Flip**: Beautiful 3D coin animations with haptic feedback
- **Manual Entry**: For those using physical coins or yarrow stalks
- Support for changing lines and transformed hexagrams

### 📚 Complete I Ching Library
- All 64 hexagrams with authentic interpretations
- Wilhelm/Baynes translation style
- Chinese names, pinyin romanization, and English translations
- The Judgment (卦辭) from King Wen
- The Image (象辭) from the Duke of Zhou
- Complete line meanings for all 384 lines
- Trigram information and relationships

### 📖 Reading History
- Save all readings with questions and timestamps
- Add personal reflections via the Journal feature
- Search and filter past readings
- iCloud sync across all your devices

### 🔔 Daily Hexagram
- Optional daily notification with a hexagram for contemplation
- Home screen widgets (iOS)
- Consistent daily hexagram that stays with you all day

### 🎨 Design
- Minimalist, zen aesthetic inspired by premium meditation apps
- Beautiful typography with Chinese character support
- Smooth animations throughout
- Full Dark Mode support
- Accessibility support (VoiceOver, Dynamic Type)

## Architecture

- **SwiftUI** for the entire UI layer
- **SwiftData** for persistence
- **CloudKit** for iCloud sync
- **WidgetKit** for home screen widgets
- **MVVM** architecture with `@Observable`

## Project Structure

```
IChing/
├── App/
│   ├── IChingApp.swift
│   └── ContentView.swift
├── Models/
│   ├── Trigram.swift
│   ├── Line.swift
│   ├── Hexagram.swift
│   ├── HexagramLibrary.swift
│   ├── HexagramData1-4.swift    # All 64 hexagrams
│   ├── Reading.swift
│   ├── JournalEntry.swift
│   └── AppSettings.swift
├── Views/
│   ├── Screens/
│   │   ├── DivineView.swift
│   │   ├── LibraryView.swift
│   │   ├── HistoryView.swift
│   │   ├── JournalListView.swift
│   │   └── SettingsView.swift
│   ├── Reading/
│   │   ├── ReadingDetailView.swift
│   │   ├── HexagramDetailView.swift
│   │   ├── JournalEditorView.swift
│   │   └── ManualEntryView.swift
│   └── Components/
│       ├── HexagramView.swift
│       ├── CoinFlipView.swift
│       └── TrigramView.swift
├── ViewModels/
│   └── DivineViewModel.swift
├── Services/
│   ├── NotificationService.swift
│   └── HapticService.swift
├── Extensions/
│   ├── Color+Theme.swift
│   └── View+Extensions.swift
└── Utilities/
    └── DateFormatters.swift

IChingWidgets/
├── IChingWidgets.swift
└── Info.plist
```

## Requirements

- iOS 17.0+ / macOS 14.0+
- Xcode 15.0+
- Swift 5.9+

## Getting Started

1. Clone the repository
2. Open `IChing.xcodeproj` in Xcode
3. Select your target device/simulator
4. Build and run (⌘R)

## Customization

### Adding Your Own Interpretations

The hexagram data is stored in `HexagramData1-4.swift`. Each hexagram contains:
- Basic information (name, number, trigrams)
- Judgment and Image texts
- Commentary
- Line meanings

### Theming

Colors are defined in `Assets.xcassets` and `Color+Theme.swift`. The app uses semantic colors for easy customization.

## Credits

The interpretations in this app are inspired by the Richard Wilhelm translation, rendered into English by Cary F. Baynes. This translation remains the most authoritative and influential English language edition of the I Ching.

## License

This project is available for personal and educational use. The I Ching texts are in the public domain.

---

*May this app serve as a worthy vessel for ancient wisdom.* 🙏
