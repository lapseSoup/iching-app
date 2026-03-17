import Foundation

/// Represents one of the eight trigrams (八卦) of the I Ching
enum Trigram: Int, Codable, CaseIterable, Identifiable {
    case heaven = 0  // ☰ 乾 qián - Creative
    case lake = 1    // ☱ 兌 duì - Joyous
    case fire = 2    // ☲ 離 lí - Clinging
    case thunder = 3 // ☳ 震 zhèn - Arousing
    case wind = 4    // ☴ 巽 xùn - Gentle
    case water = 5   // ☵ 坎 kǎn - Abysmal
    case mountain = 6 // ☶ 艮 gèn - Keeping Still
    case earth = 7   // ☷ 坤 kūn - Receptive
    
    var id: Int { rawValue }
    
    /// The three lines of the trigram, from bottom to top (true = yang/solid, false = yin/broken)
    var lines: [Bool] {
        switch self {
        case .heaven:   return [true, true, true]
        case .lake:     return [true, true, false]
        case .fire:     return [true, false, true]
        case .thunder:  return [true, false, false]
        case .wind:     return [false, true, true]
        case .water:    return [false, true, false]
        case .mountain: return [false, false, true]
        case .earth:    return [false, false, false]
        }
    }
    
    /// Unicode symbol for the trigram
    var symbol: String {
        switch self {
        case .heaven:   return "☰"
        case .lake:     return "☱"
        case .fire:     return "☲"
        case .thunder:  return "☳"
        case .wind:     return "☴"
        case .water:    return "☵"
        case .mountain: return "☶"
        case .earth:    return "☷"
        }
    }
    
    /// Chinese character name
    var chineseName: String {
        switch self {
        case .heaven:   return "乾"
        case .lake:     return "兌"
        case .fire:     return "離"
        case .thunder:  return "震"
        case .wind:     return "巽"
        case .water:    return "坎"
        case .mountain: return "艮"
        case .earth:    return "坤"
        }
    }
    
    /// Pinyin romanization
    var pinyin: String {
        switch self {
        case .heaven:   return "qián"
        case .lake:     return "duì"
        case .fire:     return "lí"
        case .thunder:  return "zhèn"
        case .wind:     return "xùn"
        case .water:    return "kǎn"
        case .mountain: return "gèn"
        case .earth:    return "kūn"
        }
    }
    
    /// English name/meaning
    var englishName: String {
        switch self {
        case .heaven:   return "The Creative"
        case .lake:     return "The Joyous"
        case .fire:     return "The Clinging"
        case .thunder:  return "The Arousing"
        case .wind:     return "The Gentle"
        case .water:    return "The Abysmal"
        case .mountain: return "Keeping Still"
        case .earth:    return "The Receptive"
        }
    }
    
    /// Natural element/image
    var element: String {
        switch self {
        case .heaven:   return "Heaven"
        case .lake:     return "Lake"
        case .fire:     return "Fire"
        case .thunder:  return "Thunder"
        case .wind:     return "Wind"
        case .water:    return "Water"
        case .mountain: return "Mountain"
        case .earth:    return "Earth"
        }
    }
    
    /// Associated quality
    var quality: String {
        switch self {
        case .heaven:   return "Strong"
        case .lake:     return "Joyful"
        case .fire:     return "Radiant"
        case .thunder:  return "Inciting"
        case .wind:     return "Penetrating"
        case .water:    return "Dangerous"
        case .mountain: return "Resting"
        case .earth:    return "Yielding"
        }
    }
    
    /// Family member association
    var familyMember: String {
        switch self {
        case .heaven:   return "Father"
        case .lake:     return "Youngest Daughter"
        case .fire:     return "Middle Daughter"
        case .thunder:  return "Eldest Son"
        case .wind:     return "Eldest Daughter"
        case .water:    return "Middle Son"
        case .mountain: return "Youngest Son"
        case .earth:    return "Mother"
        }
    }
    
    /// O(1) lookup from three lines (bottom to top)
    private static let lineMap: [[Bool]: Trigram] = {
        var map = [[Bool]: Trigram]()
        for trigram in Trigram.allCases {
            map[trigram.lines] = trigram
        }
        return map
    }()

    /// Create trigram from three lines (bottom to top)
    static func from(lines: [Bool]) -> Trigram? {
        guard lines.count == 3 else { return nil }
        return lineMap[lines]
    }
}
