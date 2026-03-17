import Foundation

/// Minimal hexagram data shared between the main app and widget extension.
/// Add this file to BOTH the IChing and IChingWidgets targets in Xcode.
struct HexagramBasicInfo: Codable, Identifiable {
    let id: Int
    let name: String
    let chineseName: String
    let character: String
    let lines: [Bool] // true = yang (solid), bottom to top

    /// All 64 hexagrams — single source of truth for basic display data
    static let all: [HexagramBasicInfo] = [
        HexagramBasicInfo(id: 1, name: "The Creative", chineseName: "乾", character: "䷀", lines: [true, true, true, true, true, true]),
        HexagramBasicInfo(id: 2, name: "The Receptive", chineseName: "坤", character: "䷁", lines: [false, false, false, false, false, false]),
        HexagramBasicInfo(id: 3, name: "Difficulty at the Beginning", chineseName: "屯", character: "䷂", lines: [true, false, false, false, true, false]),
        HexagramBasicInfo(id: 4, name: "Youthful Folly", chineseName: "蒙", character: "䷃", lines: [false, true, false, false, false, true]),
        HexagramBasicInfo(id: 5, name: "Waiting", chineseName: "需", character: "䷄", lines: [true, true, true, false, true, false]),
        HexagramBasicInfo(id: 6, name: "Conflict", chineseName: "訟", character: "䷅", lines: [false, true, false, true, true, true]),
        HexagramBasicInfo(id: 7, name: "The Army", chineseName: "師", character: "䷆", lines: [false, true, false, false, false, false]),
        HexagramBasicInfo(id: 8, name: "Holding Together", chineseName: "比", character: "䷇", lines: [false, false, false, false, true, false]),
        HexagramBasicInfo(id: 9, name: "The Taming Power of the Small", chineseName: "小畜", character: "䷈", lines: [true, true, true, false, true, true]),
        HexagramBasicInfo(id: 10, name: "Treading", chineseName: "履", character: "䷉", lines: [true, true, false, true, true, true]),
        HexagramBasicInfo(id: 11, name: "Peace", chineseName: "泰", character: "䷊", lines: [true, true, true, false, false, false]),
        HexagramBasicInfo(id: 12, name: "Standstill", chineseName: "否", character: "䷋", lines: [false, false, false, true, true, true]),
        HexagramBasicInfo(id: 13, name: "Fellowship with Men", chineseName: "同人", character: "䷌", lines: [true, false, true, true, true, true]),
        HexagramBasicInfo(id: 14, name: "Possession in Great Measure", chineseName: "大有", character: "䷍", lines: [true, true, true, true, false, true]),
        HexagramBasicInfo(id: 15, name: "Modesty", chineseName: "謙", character: "䷎", lines: [false, false, true, false, false, false]),
        HexagramBasicInfo(id: 16, name: "Enthusiasm", chineseName: "豫", character: "䷏", lines: [false, false, false, true, false, false]),
        HexagramBasicInfo(id: 17, name: "Following", chineseName: "隨", character: "䷐", lines: [true, false, false, true, true, false]),
        HexagramBasicInfo(id: 18, name: "Work on What Has Been Spoiled", chineseName: "蠱", character: "䷑", lines: [false, true, true, false, false, true]),
        HexagramBasicInfo(id: 19, name: "Approach", chineseName: "臨", character: "䷒", lines: [true, true, false, false, false, false]),
        HexagramBasicInfo(id: 20, name: "Contemplation", chineseName: "觀", character: "䷓", lines: [false, false, false, false, true, true]),
        HexagramBasicInfo(id: 21, name: "Biting Through", chineseName: "噬嗑", character: "䷔", lines: [true, false, false, true, false, true]),
        HexagramBasicInfo(id: 22, name: "Grace", chineseName: "賁", character: "䷕", lines: [true, false, true, false, false, true]),
        HexagramBasicInfo(id: 23, name: "Splitting Apart", chineseName: "剝", character: "䷖", lines: [false, false, false, false, false, true]),
        HexagramBasicInfo(id: 24, name: "Return", chineseName: "復", character: "䷗", lines: [true, false, false, false, false, false]),
        HexagramBasicInfo(id: 25, name: "Innocence", chineseName: "无妄", character: "䷘", lines: [true, false, false, true, true, true]),
        HexagramBasicInfo(id: 26, name: "The Taming Power of the Great", chineseName: "大畜", character: "䷙", lines: [true, true, true, false, false, true]),
        HexagramBasicInfo(id: 27, name: "Providing Nourishment", chineseName: "頤", character: "䷚", lines: [true, false, false, false, false, true]),
        HexagramBasicInfo(id: 28, name: "Preponderance of the Great", chineseName: "大過", character: "䷛", lines: [false, true, true, true, true, false]),
        HexagramBasicInfo(id: 29, name: "The Abysmal", chineseName: "坎", character: "䷜", lines: [false, true, false, false, true, false]),
        HexagramBasicInfo(id: 30, name: "The Clinging", chineseName: "離", character: "䷝", lines: [true, false, true, true, false, true]),
        HexagramBasicInfo(id: 31, name: "Influence", chineseName: "咸", character: "䷞", lines: [false, false, true, true, true, false]),
        HexagramBasicInfo(id: 32, name: "Duration", chineseName: "恆", character: "䷟", lines: [false, true, true, true, false, false]),
        HexagramBasicInfo(id: 33, name: "Retreat", chineseName: "遯", character: "䷠", lines: [false, false, true, true, true, true]),
        HexagramBasicInfo(id: 34, name: "The Power of the Great", chineseName: "大壯", character: "䷡", lines: [true, true, true, true, false, false]),
        HexagramBasicInfo(id: 35, name: "Progress", chineseName: "晉", character: "䷢", lines: [false, false, false, true, false, true]),
        HexagramBasicInfo(id: 36, name: "Darkening of the Light", chineseName: "明夷", character: "䷣", lines: [true, false, true, false, false, false]),
        HexagramBasicInfo(id: 37, name: "The Family", chineseName: "家人", character: "䷤", lines: [true, false, true, false, true, true]),
        HexagramBasicInfo(id: 38, name: "Opposition", chineseName: "睽", character: "䷥", lines: [true, true, false, true, false, true]),
        HexagramBasicInfo(id: 39, name: "Obstruction", chineseName: "蹇", character: "䷦", lines: [false, false, true, false, true, false]),
        HexagramBasicInfo(id: 40, name: "Deliverance", chineseName: "解", character: "䷧", lines: [false, true, false, true, false, false]),
        HexagramBasicInfo(id: 41, name: "Decrease", chineseName: "損", character: "䷨", lines: [true, true, false, false, false, true]),
        HexagramBasicInfo(id: 42, name: "Increase", chineseName: "益", character: "䷩", lines: [true, false, false, false, true, true]),
        HexagramBasicInfo(id: 43, name: "Break-through", chineseName: "夬", character: "䷪", lines: [true, true, true, true, true, false]),
        HexagramBasicInfo(id: 44, name: "Coming to Meet", chineseName: "姤", character: "䷫", lines: [false, true, true, true, true, true]),
        HexagramBasicInfo(id: 45, name: "Gathering Together", chineseName: "萃", character: "䷬", lines: [false, false, false, true, true, false]),
        HexagramBasicInfo(id: 46, name: "Pushing Upward", chineseName: "升", character: "䷭", lines: [false, true, true, false, false, false]),
        HexagramBasicInfo(id: 47, name: "Oppression", chineseName: "困", character: "䷮", lines: [false, true, false, true, true, false]),
        HexagramBasicInfo(id: 48, name: "The Well", chineseName: "井", character: "䷯", lines: [false, true, true, false, true, false]),
        HexagramBasicInfo(id: 49, name: "Revolution", chineseName: "革", character: "䷰", lines: [true, false, true, true, true, false]),
        HexagramBasicInfo(id: 50, name: "The Caldron", chineseName: "鼎", character: "䷱", lines: [false, true, true, true, false, true]),
        HexagramBasicInfo(id: 51, name: "The Arousing", chineseName: "震", character: "䷲", lines: [true, false, false, true, false, false]),
        HexagramBasicInfo(id: 52, name: "Keeping Still", chineseName: "艮", character: "䷳", lines: [false, false, true, false, false, true]),
        HexagramBasicInfo(id: 53, name: "Gradual Progress", chineseName: "漸", character: "䷴", lines: [false, false, true, false, true, true]),
        HexagramBasicInfo(id: 54, name: "The Marrying Maiden", chineseName: "歸妹", character: "䷵", lines: [true, true, false, true, false, false]),
        HexagramBasicInfo(id: 55, name: "Abundance", chineseName: "豐", character: "䷶", lines: [true, false, true, true, false, false]),
        HexagramBasicInfo(id: 56, name: "The Wanderer", chineseName: "旅", character: "䷷", lines: [false, false, true, true, false, true]),
        HexagramBasicInfo(id: 57, name: "The Gentle", chineseName: "巽", character: "䷸", lines: [false, true, true, false, true, true]),
        HexagramBasicInfo(id: 58, name: "The Joyous", chineseName: "兌", character: "䷹", lines: [true, true, false, true, true, false]),
        HexagramBasicInfo(id: 59, name: "Dispersion", chineseName: "渙", character: "䷺", lines: [false, true, false, false, true, true]),
        HexagramBasicInfo(id: 60, name: "Limitation", chineseName: "節", character: "䷻", lines: [true, true, false, false, true, false]),
        HexagramBasicInfo(id: 61, name: "Inner Truth", chineseName: "中孚", character: "䷼", lines: [true, true, false, false, true, true]),
        HexagramBasicInfo(id: 62, name: "Preponderance of the Small", chineseName: "小過", character: "䷽", lines: [false, false, true, true, false, false]),
        HexagramBasicInfo(id: 63, name: "After Completion", chineseName: "既濟", character: "䷾", lines: [true, false, true, false, true, false]),
        HexagramBasicInfo(id: 64, name: "Before Completion", chineseName: "未濟", character: "䷿", lines: [false, true, false, true, false, true]),
    ]

    /// Deterministic daily hexagram ID based on date.
    /// Shared algorithm — used by both widget and notification service.
    static func dailyHexagramId(for date: Date) -> Int {
        let calendar = Calendar.current
        let day = calendar.ordinality(of: .day, in: .era, for: date) ?? 1
        return (day % 64) + 1
    }
}
