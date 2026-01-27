import Foundation

enum DateFormatters {
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    static let longDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
    static let timeOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    static let monthYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    static let relative: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }()
}

extension Date {
    var shortFormatted: String {
        DateFormatters.shortDate.string(from: self)
    }
    
    var longFormatted: String {
        DateFormatters.longDate.string(from: self)
    }
    
    var timeFormatted: String {
        DateFormatters.timeOnly.string(from: self)
    }
    
    var relativeFormatted: String {
        DateFormatters.relative.localizedString(for: self, relativeTo: Date())
    }
}
