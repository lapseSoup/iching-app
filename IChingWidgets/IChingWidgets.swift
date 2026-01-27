import WidgetKit
import SwiftUI

// MARK: - Widget Entry

struct DailyHexagramEntry: TimelineEntry {
    let date: Date
    let hexagram: WidgetHexagram
}

struct WidgetHexagram {
    let id: Int
    let name: String
    let chineseName: String
    let character: String
    let lines: [Bool] // true = yang (solid)
    
    static let placeholder = WidgetHexagram(
        id: 1,
        name: "The Creative",
        chineseName: "乾",
        character: "䷀",
        lines: [true, true, true, true, true, true]
    )
    
    static func random() -> WidgetHexagram {
        let hexagrams = allHexagrams
        return hexagrams[Int.random(in: 0..<hexagrams.count)]
    }
    
    static let allHexagrams: [WidgetHexagram] = [
        WidgetHexagram(id: 1, name: "The Creative", chineseName: "乾", character: "䷀", lines: [true, true, true, true, true, true]),
        WidgetHexagram(id: 2, name: "The Receptive", chineseName: "坤", character: "䷁", lines: [false, false, false, false, false, false]),
        WidgetHexagram(id: 11, name: "Peace", chineseName: "泰", character: "䷊", lines: [true, true, true, false, false, false]),
        WidgetHexagram(id: 12, name: "Standstill", chineseName: "否", character: "䷋", lines: [false, false, false, true, true, true]),
        WidgetHexagram(id: 15, name: "Modesty", chineseName: "謙", character: "䷎", lines: [false, false, true, false, false, false]),
        WidgetHexagram(id: 24, name: "Return", chineseName: "復", character: "䷗", lines: [true, false, false, false, false, false]),
        WidgetHexagram(id: 29, name: "The Abysmal", chineseName: "坎", character: "䷜", lines: [false, true, false, false, true, false]),
        WidgetHexagram(id: 30, name: "The Clinging", chineseName: "離", character: "䷝", lines: [true, false, true, true, false, true]),
        WidgetHexagram(id: 61, name: "Inner Truth", chineseName: "中孚", character: "䷼", lines: [true, true, false, false, true, true]),
        WidgetHexagram(id: 63, name: "After Completion", chineseName: "既濟", character: "䷾", lines: [false, true, false, true, false, true]),
        WidgetHexagram(id: 64, name: "Before Completion", chineseName: "未濟", character: "䷿", lines: [true, false, true, false, true, false])
        // Add more as needed, or load from shared data
    ]
}

// MARK: - Timeline Provider

struct DailyHexagramProvider: TimelineProvider {
    func placeholder(in context: Context) -> DailyHexagramEntry {
        DailyHexagramEntry(date: Date(), hexagram: .placeholder)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (DailyHexagramEntry) -> Void) {
        let entry = DailyHexagramEntry(date: Date(), hexagram: .random())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<DailyHexagramEntry>) -> Void) {
        let currentDate = Date()
        let calendar = Calendar.current
        
        // Create entry for today
        let hexagram = getDailyHexagram(for: currentDate)
        let entry = DailyHexagramEntry(date: currentDate, hexagram: hexagram)
        
        // Next update at midnight
        let tomorrow = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: currentDate)!)
        
        let timeline = Timeline(entries: [entry], policy: .after(tomorrow))
        completion(timeline)
    }
    
    private func getDailyHexagram(for date: Date) -> WidgetHexagram {
        // Use date as seed for consistent daily hexagram
        let calendar = Calendar.current
        let day = calendar.ordinality(of: .day, in: .era, for: date) ?? 0
        let index = day % WidgetHexagram.allHexagrams.count
        return WidgetHexagram.allHexagrams[index]
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
    DailyHexagramEntry(date: Date(), hexagram: .placeholder)
}

#Preview("Medium", as: .systemMedium) {
    DailyHexagramWidget()
} timeline: {
    DailyHexagramEntry(date: Date(), hexagram: .placeholder)
}
