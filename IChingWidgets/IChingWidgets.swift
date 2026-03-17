import WidgetKit
import SwiftUI

// MARK: - Widget Entry

struct DailyHexagramEntry: TimelineEntry {
    let date: Date
    let hexagram: HexagramBasicInfo
}

// MARK: - Timeline Provider

struct DailyHexagramProvider: TimelineProvider {
    func placeholder(in context: Context) -> DailyHexagramEntry {
        DailyHexagramEntry(date: Date(), hexagram: HexagramBasicInfo.all[0])
    }

    func getSnapshot(in context: Context, completion: @escaping (DailyHexagramEntry) -> Void) {
        let entry = DailyHexagramEntry(date: Date(), hexagram: HexagramBasicInfo.all.randomElement() ?? HexagramBasicInfo.all[0])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<DailyHexagramEntry>) -> Void) {
        let currentDate = Date()
        let calendar = Calendar.current

        // Create entry for today using shared daily hexagram algorithm
        let hexagramId = HexagramBasicInfo.dailyHexagramId(for: currentDate)
        let hexagram = HexagramBasicInfo.all[hexagramId - 1]
        let entry = DailyHexagramEntry(date: currentDate, hexagram: hexagram)

        // Next update at midnight
        let tomorrow = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate.addingTimeInterval(86400))

        let timeline = Timeline(entries: [entry], policy: .after(tomorrow))
        completion(timeline)
    }
}

// MARK: - Widget Views

struct SmallWidgetView: View {
    let entry: DailyHexagramEntry

    var body: some View {
        VStack(spacing: 8) {
            Text(entry.hexagram.character)
                .font(.system(size: 36))

            Text(entry.hexagram.name)
                .font(.caption.weight(.medium))
                .lineLimit(2)
                .multilineTextAlignment(.center)

            Text(entry.hexagram.chineseName)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .containerBackground(.fill.tertiary, for: .widget)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Daily Hexagram: \(entry.hexagram.name), \(entry.hexagram.chineseName)")
    }
}

struct MediumWidgetView: View {
    let entry: DailyHexagramEntry

    var body: some View {
        HStack(spacing: 16) {
            // Hexagram visualization
            VStack(spacing: 4) {
                ForEach((0..<6).reversed(), id: \.self) { index in
                    WidgetLineView(isYang: entry.hexagram.lines[index])
                }
            }
            .frame(width: 60)

            VStack(alignment: .leading, spacing: 4) {
                Text("Daily Hexagram")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(entry.hexagram.name)
                    .font(.headline)

                HStack(spacing: 4) {
                    Text(entry.hexagram.chineseName)
                    Text("•")
                    Text("#\(entry.hexagram.id)")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Daily Hexagram: number \(entry.hexagram.id), \(entry.hexagram.name), \(entry.hexagram.chineseName)")
    }
}

struct WidgetLineView: View {
    let isYang: Bool

    var body: some View {
        Group {
            if isYang {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.primary)
            } else {
                HStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.primary)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.primary)
                }
            }
        }
        .frame(height: 6)
    }
}

// MARK: - Widget Configuration

struct DailyHexagramWidget: Widget {
    let kind: String = "DailyHexagramWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DailyHexagramProvider()) { entry in
            DailyHexagramWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Daily Hexagram")
        .description("Shows your daily I Ching hexagram for contemplation.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct DailyHexagramWidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    let entry: DailyHexagramEntry

    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
        default:
            SmallWidgetView(entry: entry)
        }
    }
}

// MARK: - Widget Bundle

@main
struct IChingWidgetBundle: WidgetBundle {
    var body: some Widget {
        DailyHexagramWidget()
    }
}

#Preview("Small", as: .systemSmall) {
    DailyHexagramWidget()
} timeline: {
    DailyHexagramEntry(date: Date(), hexagram: HexagramBasicInfo.all[0])
}

#Preview("Medium", as: .systemMedium) {
    DailyHexagramWidget()
} timeline: {
    DailyHexagramEntry(date: Date(), hexagram: HexagramBasicInfo.all[0])
}
