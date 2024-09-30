//
//  DutyTime.swift
//
//
//  Created by Junyoung on 9/26/24.
//

import Foundation

public enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    case holiday
    
    public var toString: String {
        switch self {
        case .monday:
            return "🗓️ 월요일"
        case .tuesday:
            return "🗓️ 화요일"
        case .wednesday:
            return "🗓️ 수요일"
        case .thursday:
            return "🗓️ 목요일"
        case .friday:
            return "🗓️ 금요일"
        case .saturday:
            return "🗓️ 토요일"
        case .sunday:
            return "🗓️ 일요일"
        case .holiday:
            return "🗓️ 공휴일"
        }
    }
}

public struct DutyTime {
    public let weekDay: Weekday
    public let start: String?
    public let end: String?
    
    public init(weekDay: Weekday, start: String?, end: String?) {
        self.weekDay = weekDay
        self.start = start
        self.end = end
    }
    
    public func displayTime() -> String {
        guard let start = start, let end = end else { return "Closed"}
        
        return "\(start.prefix(2)):\(start.suffix(2)) ~ \(end.prefix(2)):\(end.suffix(2))"
    }
}
