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

enum IChingSchemaV3: VersionedSchema {
    static var versionIdentifier = Schema.Version(3, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Reading.self, JournalEntry.self, AppSettings.self]
    }
}

enum IChingMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [IChingSchemaV1.self, IChingSchemaV2.self, IChingSchemaV3.self]
    }

    static var stages: [MigrationStage] {
        [migrateV1toV2, migrateV2toV3]
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
}

@main
struct IChingApp: App {
    let modelContainer: ModelContainer?
    private let initError: String?
    @State private var didResetDatabase = false

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

    /// Removes the SwiftData store files to allow a fresh start on next launch.
    /// Returns true if files were deleted successfully.
    private static func resetDatabase() -> Bool {
        guard let appSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return false }
        let fileManager = FileManager.default
        // Match all .store files and their WAL/SHM companions
        let extensions = ["store", "store-shm", "store-wal"]
        var deleted = false
        if let contents = try? fileManager.contentsOfDirectory(at: appSupportURL, includingPropertiesForKeys: nil) {
            for url in contents where extensions.contains(where: { url.pathExtension == $0 }) {
                try? fileManager.removeItem(at: url)
                deleted = true
            }
        }
        return deleted
    }

    /// Sets NSFileProtection on the SwiftData store directory to encrypt at rest.
    /// Data is only accessible when the device is unlocked.
    private static func enableDataProtection() {
        #if os(iOS)
        guard let storeURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return }
        try? FileManager.default.setAttributes(
            [.protectionKey: FileProtectionType.complete],
            ofItemAtPath: storeURL.path
        )
        #endif
    }

    var body: some Scene {
        WindowGroup {
            if let modelContainer {
                ContentView()
                    .modelContainer(modelContainer)
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
                        Text(initError ?? "An unknown error occurred.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
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
