import SwiftUI
import SwiftData
import os.log

// MARK: - Schema Versioning

// V1: Initial schema — Reading (with individual lineValue1-6 properties), JournalEntry, AppSettings
enum IChingSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Reading.self, JournalEntry.self, AppSettings.self]
    }
}

// V2: Added lineValuesRaw array to Reading, iCloudSyncEnabled to AppSettings
enum IChingSchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(2, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Reading.self, JournalEntry.self, AppSettings.self]
    }
}

// V3: Removed legacy lineValue1-6 individual fields from Reading (now uses lineValuesRaw array only)
enum IChingSchemaV3: VersionedSchema {
    static var versionIdentifier = Schema.Version(3, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Reading.self, JournalEntry.self, AppSettings.self]
    }
}

// V4: Converted AppSettings.colorScheme and .defaultReadingMethod from raw Strings to Codable enums
enum IChingSchemaV4: VersionedSchema {
    static var versionIdentifier = Schema.Version(4, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Reading.self, JournalEntry.self, AppSettings.self]
    }
}

enum IChingMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [IChingSchemaV1.self, IChingSchemaV2.self, IChingSchemaV3.self, IChingSchemaV4.self]
    }

    static var stages: [MigrationStage] {
        [migrateV1toV2, migrateV2toV3, migrateV3toV4]
    }

    // V1→V2: Adds lineValuesRaw array and iCloudSyncEnabled to AppSettings.
    // Lightweight migration — SwiftData auto-fills new fields with defaults.
    static let migrateV1toV2 = MigrationStage.lightweight(
        fromVersion: IChingSchemaV1.self,
        toVersion: IChingSchemaV2.self
    )

    // V2→V3: Removes legacy lineValue1-6 fields from Reading.
    // Lightweight migration — SwiftData handles column removal automatically.
    static let migrateV2toV3 = MigrationStage.lightweight(
        fromVersion: IChingSchemaV2.self,
        toVersion: IChingSchemaV3.self
    )

    // V3→V4: Converts colorScheme and defaultReadingMethod from String to Codable enum.
    // Lightweight migration — SwiftData stores Codable enums as their raw value, so the
    // underlying column type (String) is unchanged and no data transformation is needed.
    static let migrateV3toV4 = MigrationStage.lightweight(
        fromVersion: IChingSchemaV3.self,
        toVersion: IChingSchemaV4.self
    )
}

@main
struct IChingApp: App {
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.iching.app", category: "App")

    let modelContainer: ModelContainer?
    private let initError: String?
    @State private var didResetDatabase = false
    // A-48: SettingsManager is initialized synchronously in init() so the first body
    // evaluation already sees real settings — no one-frame default-flicker.
    @State private var settingsManager: SettingsManager?

    init() {
        let container: ModelContainer?
        let errorMessage: String?
        do {
            let schema = Schema([
                Reading.self,
                JournalEntry.self,
                AppSettings.self
            ])

            // Default to no CloudKit sync — user must opt in via Settings
            // allowsSave: true ensures data is persisted (not read-only)
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false,
                allowsSave: true,
                cloudKitDatabase: .none
            )

            container = try ModelContainer(
                for: schema,
                migrationPlan: IChingMigrationPlan.self,
                configurations: [modelConfiguration]
            )
            errorMessage = nil
        } catch {
            container = nil
            errorMessage = error.localizedDescription
        }

        modelContainer = container
        initError = errorMessage

        // Build the SettingsManager up front when the container is healthy. SettingsManager
        // must be created on the main actor; IChingApp.init() runs on the main actor by
        // virtue of being the @main App, so it's safe.
        if let container {
            _settingsManager = State(initialValue: SettingsManager(modelContext: container.mainContext))
        } else {
            _settingsManager = State(initialValue: nil)
        }

        // Enable file-level encryption for the SwiftData store
        Self.enableDataProtection()
    }

    /// Removes the SwiftData store files to allow a fresh start on next launch.
    /// Returns true if files were deleted successfully.
    private static func resetDatabase() -> Bool {
        guard let appSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return false }
        let fileManager = FileManager.default
        let extensions = ["store", "store-shm", "store-wal"]
        var primaryStoreDeleted = false
        if let contents = try? fileManager.contentsOfDirectory(at: appSupportURL, includingPropertiesForKeys: nil) {
            for url in contents where extensions.contains(where: { url.pathExtension == $0 }) {
                do {
                    try fileManager.removeItem(at: url)
                    if url.pathExtension == "store" {
                        primaryStoreDeleted = true
                    }
                } catch {
                    // If primary .store file failed to delete, report failure
                    if url.pathExtension == "store" {
                        return false
                    }
                }
            }
        }
        return primaryStoreDeleted
    }

    /// Sets NSFileProtection on the SwiftData store directory to encrypt at rest.
    /// Data is only accessible when the device is unlocked.
    private static func enableDataProtection() {
        #if os(iOS)
        guard let storeURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return }
        do {
            try FileManager.default.setAttributes(
                [.protectionKey: FileProtectionType.complete],
                ofItemAtPath: storeURL.path
            )
        } catch {
            logger.error("Failed to enable data protection: \(error.localizedDescription, privacy: .public)")
        }
        #endif
    }

    var body: some Scene {
        WindowGroup {
            if let modelContainer {
                ContentView()
                    .modelContainer(modelContainer)
                    .environment(\.settingsManager, settingsManager)
                    .environment(\.navigationCoordinator, NavigationCoordinator.shared)
                    // A-50: stateless services are bundled. The individual environment
                    // keys remain available (with the same defaults) for tests that need
                    // to override a single service.
                    .environment(\.services, .default)
                    .onOpenURL { url in
                        NavigationCoordinator.shared.handle(url: url)
                    }
            } else {
                VStack(spacing: 16) {
                    Image(systemName: didResetDatabase ? "checkmark.circle" : "exclamationmark.triangle")
                        .font(.system(size: 48))
                        .foregroundStyle(didResetDatabase ? .green : .secondary)

                    Text(didResetDatabase ? "Data Reset Complete" : "Unable to Load Data")
                        .font(.title2.bold())

                    if didResetDatabase {
                        Text("Please quit and reopen the app to start fresh.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    } else {
                        Text("The app was unable to load its data store. This may be due to a corrupted database or a software update.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .onAppear {
                                if let initError {
                                    Self.logger.error("ModelContainer init failed: \(initError, privacy: .private)")
                                }
                            }
                        Text("Try restarting the app. If this persists, tap Reset Data below.")
                            .font(.caption)
                            .foregroundStyle(.tertiary)

                        Button("Reset Data", role: .destructive) {
                            if Self.resetDatabase() {
                                didResetDatabase = true
                            }
                        }
                        .buttonStyle(.bordered)
                        .padding(.top, 8)
                    }
                }
                .padding()
            }
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 900, height: 700)
        #endif
    }
}
