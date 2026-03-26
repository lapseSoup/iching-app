import Foundation

/// Represents a single line in a hexagram reading
struct Line: Codable, Identifiable, Equatable {
    let id: UUID
    let position: Int // 1-6, bottom to top
    let value: LineValue
    
    init(position: Int, value: LineValue) {
        self.id = UUID()
        self.position = position
        self.value = value
    }
    
    /// Whether this line is yang (solid) or yin (broken) for the primary hexagram
    var isYang: Bool {
        value.isYang
    }

    /// Whether this line is a changing/moving line
    var isChanging: Bool {
        value.isChanging
    }
}

/// The four possible values for a line based on coin/yarrow stalk divination
enum LineValue: Int, Codable, CaseIterable {
    case oldYin = 6      // ⚋ Changing yin (broken, will become solid) - 3 tails
    case youngYang = 7   // ⚊ Stable yang (solid) - 2 tails, 1 head
    case youngYin = 8    // ⚋ Stable yin (broken) - 2 heads, 1 tail
    case oldYang = 9     // ⚊ Changing yang (solid, will become broken) - 3 heads
    
    var isYang: Bool {
        self == .youngYang || self == .oldYang
    }
    
    var isChanging: Bool {
        self == .oldYang || self == .oldYin
    }
    
    var changingSymbol: String? {
        switch self {
        case .oldYang: return "○"  // Circle indicates changing yang
        case .oldYin: return "×"   // X indicates changing yin
        default: return nil
        }
    }
    
    /// Create from coin flip result (number of heads: 0-3)
    static func from(heads: Int) -> LineValue {
        switch heads {
        case 0: return .oldYin    // 0 heads (2+2+2) = 6
        case 1: return .youngYang // 1 head  (3+2+2) = 7
        case 2: return .youngYin  // 2 heads (3+3+2) = 8
        case 3: return .oldYang   // 3 heads (3+3+3) = 9
        default: return .youngYang
        }
    }
}
