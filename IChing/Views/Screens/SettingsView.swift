import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @Query private var settingsArray: [AppSettings]
    @State private var hasEnsuredSettings = false

    private var settings: AppSettings {
        settingsArray.first ?? AppSettings()
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Daily Hexagram") {
                    Toggle("Enable Daily Hexagram", isOn: Binding(
                        get: { settings.dailyHexagramEnabled },
                        set: { settings.dailyHexagramEnabled = $0 }
                    ))
                    
                    if settings.dailyHexagramEnabled {
                        DatePicker(
                            "Notification Time",
                            selection: Binding(
                                get: { settings.dailyNotificationTime },
                                set: { settings.dailyNotificationTime = $0 }
                            ),
                            displayedComponents: .hourAndMinute
                        )
                    }
                }
                
                Section("Display") {
                    Toggle("Show Chinese Characters", isOn: Binding(
                        get: { settings.showChineseCharacters },
                        set: { settings.showChineseCharacters = $0 }
                    ))
                    
                    Toggle("Show Pinyin", isOn: Binding(
                        get: { settings.showPinyin },
                        set: { settings.showPinyin = $0 }
                    ))
                }
                
                Section("Feedback") {
                    #if os(iOS)
                    Toggle("Haptic Feedback", isOn: Binding(
                        get: { settings.hapticFeedbackEnabled },
                        set: { settings.hapticFeedbackEnabled = $0 }
                    ))
                    #endif
                    
                    Toggle("Sound Effects", isOn: Binding(
                        get: { settings.soundEffectsEnabled },
                        set: { settings.soundEffectsEnabled = $0 }
                    ))
                }
                
                Section {
                    Toggle("iCloud Sync", isOn: Binding(
                        get: { settings.iCloudSyncEnabled },
                        set: { settings.iCloudSyncEnabled = $0 }
                    ))

                    if settings.iCloudSyncEnabled {
                        Text("Journal entries and readings will sync across your devices via iCloud. Data is stored in your personal iCloud account.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                } header: {
                    Text("Privacy & Data")
                } footer: {
                    if !settings.iCloudSyncEnabled {
                        Text("All data stays on this device only.")
                    }
                }

                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }
                    
                    NavigationLink("About the I Ching") {
                        AboutIChingView()
                    }
                    
                    NavigationLink("Acknowledgments") {
                        AcknowledgmentsView()
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if !hasEnsuredSettings && settingsArray.isEmpty {
                    modelContext.insert(AppSettings())
                    hasEnsuredSettings = true
                }
            }
        }
    }
}

struct AboutIChingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("About the I Ching")
                    .font(.largeTitle.weight(.bold))
                
                Text("""
                The I Ching, or "Book of Changes" (易經), is one of the oldest and most profound texts in world literature. Dating back over 3,000 years to ancient China, it has served as a source of wisdom, a divination system, and a guide for navigating life's complexities.

                The text is built upon 64 hexagrams—symbolic figures composed of six lines, each either solid (yang ☰) or broken (yin ☷). These lines combine to form the hexagrams, which represent all possible situations in life and the changes between them.

                **History**

                The I Ching's origins are attributed to the legendary sage Fu Xi, who is said to have first observed the patterns of nature and created the eight trigrams. King Wen of Zhou (c. 1150 BCE) is credited with arranging the 64 hexagrams and adding the Judgments. His son, the Duke of Zhou, added the line texts. Confucius and his school later added the Ten Wings—commentaries that deepened the philosophical meaning.

                **Divination**

                Traditionally, the I Ching was consulted through the ritual manipulation of yarrow stalks—a process that could take up to an hour. The three-coin method, which this app uses, became popular as a simpler alternative. Each throw of three coins generates a line, and six throws produce a complete hexagram.

                Changing lines (old yin or old yang) indicate transformation. When present, they create a second, "relating" hexagram that shows where the situation is heading.

                **Philosophy**

                At its heart, the I Ching teaches that change is the fundamental nature of reality. Rather than fighting change, wisdom lies in understanding its patterns and aligning oneself with them. The text emphasizes balance, timing, and the interplay of opposites.

                This app draws primarily from the Wilhelm/Baynes translation, widely regarded as the most authoritative and influential in the English language.
                """)
                .font(.body)
            }
            .padding()
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AcknowledgmentsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Acknowledgments")
                    .font(.largeTitle.weight(.bold))
                
                Text("""
                This app's interpretations are inspired by the Richard Wilhelm translation, rendered into English by Cary F. Baynes. Their work remains the definitive English language edition of the I Ching.

                We also acknowledge the contributions of countless scholars, sages, and practitioners who have preserved and transmitted this wisdom across millennia.

                The hexagram characters use the Unicode Yijing Hexagram Symbols block (U+4DC0–U+4DFF).

                May this app serve as a worthy vessel for this ancient wisdom.
                """)
                .font(.body)
            }
            .padding()
        }
        .navigationTitle("Acknowledgments")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
        .modelContainer(for: [AppSettings.self], inMemory: true)
}
