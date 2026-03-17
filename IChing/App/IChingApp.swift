import SwiftUI
import SwiftData

// MARK: - Schema Versioning

enum IChingSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Reading.self, JournalEntry.self, AppSettings.self]
    }
}

enum IChingSchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(2, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Reading.self, JournalEntry.self, AppSettings.self]
    }
}

enum IChingMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [IChingSchemaV1.self, IChingSchemaV2.self]
    }

    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }

    // V1→V2: Adds lineValuesRaw array and iCloudSyncEnabled to AppSettings.
    // Lightweight migration — SwiftData auto-fills new fields with defaults.
    static let migrateV1toV2 = MigrationStage.lightweight(
        fromVersion: IChingSchemaV1.self,
        toVersion: IChingSchemaV2.self
    )
}

@main
struct IChingApp: App {
    let modelContainer: ModelContainer?
    private let initError: String?

    init() {
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

            modelContainer = try ModelContainer(
                for: schema,
                migrationPlan: IChingMigrationPlan.self,
                configurations: [modelConfiguration]
            )
            initError = nil
        } catch {
            modelContainer = nil
            initError = error.localizedDescription
        }

        // Enable file-level encryption for the SwiftData store
        Self.enableDataProtection()
    }

    /// Sets NSFileProtection on the SwiftData store directory to encrypt at rest.
    /// Data is only accessible when the device is unlocked.
    private static func enableDataProtection() {
        #if os(iOS)
        guard let storeURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return }
        try? FileManager.default.setAttributes(
            [.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication],
            ofItemAtPath: storeURL.path
        )
        #endif
    }

    var body: some Scene {
        WindowGroup {
            if let modelContainer {
                ContentView()
                    .modelContainer(modelContainer)
            } else {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 48))
                        .foregroundStyle(.secondary)
                    Text("Unable to Load Data")
                        .font(.title2.bold())
                    Text(initError ?? "An unknown error occurred.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Text("Try restarting the app. If this persists, you may need to reinstall.")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
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
