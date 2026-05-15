import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.settingsManager) private var settingsManager
    @Environment(\.services) private var services

    private var notificationService: any NotificationServiceProtocol { services.notifications }

    /// B-62: a single task that owns notification re-scheduling. Replacing it
    /// cancels the previous attempt, so rapid toggle changes can't interleave
    /// `cancel` and `schedule` operations in the wrong order.
    @State private var notificationTask: Task<Void, Never>?

    var body: some View {
        NavigationStack {
            Group {
                if let settings = settingsManager {
                    settingsForm(settings: settings)
                } else {
                    ContentUnavailableView(
                        "Settings Unavailable",
                        systemImage: "exclamationmark.triangle",
                        description: Text("The settings store failed to load. Try restarting the app.")
                    )
                }
            }
            .navigationTitle("Settings")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func settingsForm(settings: SettingsManager) -> some View {
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
                Picker("Appearance", selection: Binding(
                    get: { settings.appColorScheme },
                    set: { settings.appColorScheme = $0 }
                )) {
                    ForEach(AppColorScheme.allCases, id: \.self) { scheme in
                        Text(scheme.displayName).tag(scheme)
                    }
                }

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

            }

            Section {
                HStack {
                    Label("iCloud Sync", systemImage: "icloud")
                    Spacer()
                    Text("Coming Soon")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            } header: {
                Text("Privacy & Data")
            } footer: {
                Text("All data stays on this device only. iCloud sync is planned for a future update.")
            }

            Section("About") {
                HStack {
                    Text("Version")
                    Spacer()
                    Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0")
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
        .onAppear {
            // B-60: SettingsManager.hapticFeedbackEnabled.setter already syncs the static,
            // but on first appearance we need to seed it from whatever was persisted.
            HapticService.isEnabled = settings.hapticFeedbackEnabled
        }
        .onChange(of: settings.dailyHexagramEnabled) { _, enabled in
            scheduleNotificationTask(enabled: enabled, time: settings.dailyNotificationTime)
        }
        .onChange(of: settings.dailyNotificationTime) { _, newTime in
            if settings.dailyHexagramEnabled {
                scheduleNotificationTask(enabled: true, time: newTime)
            }
        }
    }

    /// B-62: cancels any in-flight notification work before kicking off the new one.
    /// Without this, rapid toggle changes can interleave cancel/schedule operations
    /// and leave notifications in a state that doesn't match the toggle.
    private func scheduleNotificationTask(enabled: Bool, time: Date) {
        notificationTask?.cancel()
        let service = notificationService
        notificationTask = Task {
            if enabled {
                await service.scheduleDailyHexagram(at: time)
            } else {
                service.cancelDailyNotifications()
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
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
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
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

private struct SettingsViewPreview: View {
    @State private var manager: SettingsManager?
    let container: ModelContainer?

    init() {
        do {
            container = try ModelContainer(for: AppSettings.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        } catch {
            container = nil
        }
    }

    var body: some View {
        Group {
            if let container {
                SettingsView()
                    .modelContainer(container)
                    .environment(\.settingsManager, manager)
                    .onAppear {
                        if manager == nil {
                            manager = SettingsManager(modelContext: container.mainContext)
                        }
                    }
            } else {
                Text("Preview failed: could not create ModelContainer")
            }
        }
    }
}

#Preview {
    SettingsViewPreview()
}
