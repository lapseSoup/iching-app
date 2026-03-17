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
        WidgetHexagram(id: 3, name: "Difficulty at the Beginning", chineseName: "屯", character: "䷂", lines: [true, false, false, false, true, false]),
        WidgetHexagram(id: 4, name: "Youthful Folly", chineseName: "蒙", character: "䷃", lines: [false, true, false, false, false, true]),
        WidgetHexagram(id: 5, name: "Waiting", chineseName: "需", character: "䷄", lines: [true, true, true, false, true, false]),
        WidgetHexagram(id: 6, name: "Conflict", chineseName: "訟", character: "䷅", lines: [false, true, false, true, true, true]),
        WidgetHexagram(id: 7, name: "The Army", chineseName: "師", character: "䷆", lines: [false, true, false, false, false, false]),
        WidgetHexagram(id: 8, name: "Holding Together", chineseName: "比", character: "䷇", lines: [false, false, false, false, true, false]),
        WidgetHexagram(id: 9, name: "The Taming Power of the Small", chineseName: "小畜", character: "䷈", lines: [true, true, true, false, true, true]),
        WidgetHexagram(id: 10, name: "Treading", chineseName: "履", character: "䷉", lines: [true, true, false, true, true, true]),
        WidgetHexagram(id: 11, name: "Peace", chineseName: "泰", character: "䷊", lines: [true, true, true, false, false, false]),
        WidgetHexagram(id: 12, name: "Standstill", chineseName: "否", character: "䷋", lines: [false, false, false, true, true, true]),
        WidgetHexagram(id: 13, name: "Fellowship with Men", chineseName: "同人", character: "䷌", lines: [true, false, true, true, true, true]),
        WidgetHexagram(id: 14, name: "Possession in Great Measure", chineseName: "大有", character: "䷍", lines: [true, true, true, true, false, true]),
        WidgetHexagram(id: 15, name: "Modesty", chineseName: "謙", character: "䷎", lines: [false, false, true, false, false, false]),
        WidgetHexagram(id: 16, name: "Enthusiasm", chineseName: "豫", character: "䷏", lines: [false, false, false, true, false, false]),
        WidgetHexagram(id: 17, name: "Following", chineseName: "隨", character: "䷐", lines: [true, false, false, true, true, false]),
        WidgetHexagram(id: 18, name: "Work on What Has Been Spoiled", chineseName: "蠱", character: "䷑", lines: [false, true, true, false, false, true]),
        WidgetHexagram(id: 19, name: "Approach", chineseName: "臨", character: "䷒", lines: [true, true, false, false, false, false]),
        WidgetHexagram(id: 20, name: "Contemplation", chineseName: "觀", character: "䷓", lines: [false, false, false, false, true, true]),
        WidgetHexagram(id: 21, name: "Biting Through", chineseName: "噬嗑", character: "䷔", lines: [true, false, false, true, false, true]),
        WidgetHexagram(id: 22, name: "Grace", chineseName: "賁", character: "䷕", lines: [true, false, true, false, false, true]),
        WidgetHexagram(id: 23, name: "Splitting Apart", chineseName: "剝", character: "䷖", lines: [false, false, false, false, false, true]),
        WidgetHexagram(id: 24, name: "Return", chineseName: "復", character: "䷗", lines: [true, false, false, false, false, false]),
        WidgetHexagram(id: 25, name: "Innocence", chineseName: "无妄", character: "䷘", lines: [true, false, false, true, true, true]),
        WidgetHexagram(id: 26, name: "The Taming Power of the Great", chineseName: "大畜", character: "䷙", lines: [true, true, true, false, false, true]),
        WidgetHexagram(id: 27, name: "Providing Nourishment", chineseName: "頤", character: "䷚", lines: [true, false, false, false, false, true]),
        WidgetHexagram(id: 28, name: "Preponderance of the Great", chineseName: "大過", character: "䷛", lines: [false, true, true, true, true, false]),
        WidgetHexagram(id: 29, name: "The Abysmal", chineseName: "坎", character: "䷜", lines: [false, true, false, false, true, false]),
        WidgetHexagram(id: 30, name: "The Clinging", chineseName: "離", character: "䷝", lines: [true, false, true, true, false, true]),
        WidgetHexagram(id: 31, name: "Influence", chineseName: "咸", character: "䷞", lines: [false, false, true, true, true, false]),
        WidgetHexagram(id: 32, name: "Duration", chineseName: "恆", character: "䷟", lines: [false, true, true, true, false, false]),
        WidgetHexagram(id: 33, name: "Retreat", chineseName: "遯", character: "䷠", lines: [false, false, true, true, true, true]),
        WidgetHexagram(id: 34, name: "The Power of the Great", chineseName: "大壯", character: "䷡", lines: [true, true, true, true, false, false]),
        WidgetHexagram(id: 35, name: "Progress", chineseName: "晉", character: "䷢", lines: [false, false, false, true, false, true]),
        WidgetHexagram(id: 36, name: "Darkening of the Light", chineseName: "明夷", character: "䷣", lines: [true, false, true, false, false, false]),
        WidgetHexagram(id: 37, name: "The Family", chineseName: "家人", character: "䷤", lines: [true, false, true, false, true, true]),
        WidgetHexagram(id: 38, name: "Opposition", chineseName: "睽", character: "䷥", lines: [true, true, false, true, false, true]),
        WidgetHexagram(id: 39, name: "Obstruction", chineseName: "蹇", character: "䷦", lines: [false, false, true, false, true, false]),
        WidgetHexagram(id: 40, name: "Deliverance", chineseName: "解", character: "䷧", lines: [false, true, false, true, false, false]),
        WidgetHexagram(id: 41, name: "Decrease", chineseName: "損", character: "䷨", lines: [true, true, false, false, false, true]),
        WidgetHexagram(id: 42, name: "Increase", chineseName: "益", character: "䷩", lines: [true, false, false, false, true, true]),
        WidgetHexagram(id: 43, name: "Break-through", chineseName: "夬", character: "䷪", lines: [true, true, true, true, true, false]),
        WidgetHexagram(id: 44, name: "Coming to Meet", chineseName: "姤", character: "䷫", lines: [false, true, true, true, true, true]),
        WidgetHexagram(id: 45, name: "Gathering Together", chineseName: "萃", character: "䷬", lines: [false, false, false, true, true, false]),
        WidgetHexagram(id: 46, name: "Pushing Upward", chineseName: "升", character: "䷭", lines: [false, true, true, false, false, false]),
        WidgetHexagram(id: 47, name: "Oppression", chineseName: "困", character: "䷮", lines: [false, true, false, true, true, false]),
        WidgetHexagram(id: 48, name: "The Well", chineseName: "井", character: "䷯", lines: [false, true, true, false, true, false]),
        WidgetHexagram(id: 49, name: "Revolution", chineseName: "革", character: "䷰", lines: [true, false, true, true, true, false]),
        WidgetHexagram(id: 50, name: "The Caldron", chineseName: "鼎", character: "䷱", lines: [false, true, true, true, false, true]),
        WidgetHexagram(id: 51, name: "The Arousing", chineseName: "震", character: "䷲", lines: [true, false, false, true, false, false]),
        WidgetHexagram(id: 52, name: "Keeping Still", chineseName: "艮", character: "䷳", lines: [false, false, true, false, false, true]),
        WidgetHexagram(id: 53, name: "Gradual Progress", chineseName: "漸", character: "䷴", lines: [false, false, true, false, true, true]),
        WidgetHexagram(id: 54, name: "The Marrying Maiden", chineseName: "歸妹", character: "䷵", lines: [true, true, false, true, false, false]),
        WidgetHexagram(id: 55, name: "Abundance", chineseName: "豐", character: "䷶", lines: [true, false, true, true, false, false]),
        WidgetHexagram(id: 56, name: "The Wanderer", chineseName: "旅", character: "䷷", lines: [false, false, true, true, false, true]),
        WidgetHexagram(id: 57, name: "The Gentle", chineseName: "巽", character: "䷸", lines: [false, true, true, false, true, true]),
        WidgetHexagram(id: 58, name: "The Joyous", chineseName: "兌", character: "䷹", lines: [true, true, false, true, true, false]),
        WidgetHexagram(id: 59, name: "Dispersion", chineseName: "渙", character: "䷺", lines: [false, true, false, false, true, true]),
        WidgetHexagram(id: 60, name: "Limitation", chineseName: "節", character: "䷻", lines: [true, true, false, false, true, false]),
        WidgetHexagram(id: 61, name: "Inner Truth", chineseName: "中孚", character: "䷼", lines: [true, true, false, false, true, true]),
        WidgetHexagram(id: 62, name: "Preponderance of the Small", chineseName: "小過", character: "䷽", lines: [false, false, true, true, false, false]),
        WidgetHexagram(id: 63, name: "After Completion", chineseName: "既濟", character: "䷾", lines: [true, false, true, false, true, false]),
        WidgetHexagram(id: 64, name: "Before Completion", chineseName: "未濟", character: "䷿", lines: [false, true, false, true, false, true]),
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
        let tomorrow = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate.addingTimeInterval(86400))
        
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
