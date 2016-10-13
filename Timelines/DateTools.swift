//
//  DateTools.swift
//  Timelines
//
//  Created by Princess Sampson on 10/12/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

struct DateTools {
    static let gmtFormatter: ISO8601DateFormatter = {
        let gmtTimeZoneFormatter = ISO8601DateFormatter()
        gmtTimeZoneFormatter.timeZone = TimeZone(abbreviation: "GMT")
        
        return gmtTimeZoneFormatter
    }()
    
    static let localTimeFormatter: ISO8601DateFormatter = {
        let localTimeFormatter = ISO8601DateFormatter()
        localTimeFormatter.timeZone = TimeZone.autoupdatingCurrent

        return localTimeFormatter
    }()
    
    static func formatter(for timezone: String) -> ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: timezone)
        
        return formatter
    }
    
    static func localTimes(for event: Event) -> (start: String, end: String) {
        let start = DateTools.localTimeFormatter.date(from: event.startAsGMT())?.description(with: Locale.autoupdatingCurrent)
        let end = DateTools.localTimeFormatter.date(from: event.endAsGMT())?.description(with: Locale.autoupdatingCurrent)
        let times = (start: start!, end: end!)
        return times
    }
    
    
}
