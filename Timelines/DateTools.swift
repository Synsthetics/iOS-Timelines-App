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
    
    static func localTimes(for timeblock: Timeblock) -> (start: String, end: String) {
        let start = DateTools.localTimeFormatter.date(from: timeblock.startAsGMT())?.description(with: Locale.autoupdatingCurrent)
        let end = DateTools.localTimeFormatter.date(from: timeblock.endAsGMT())?.description(with: Locale.autoupdatingCurrent)
        let times = (start: start!, end: end!)
        return times
    }
    
    static func eventsView(start: Date, end: Date) -> (date: String, startToEnd: String) {
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "h:mm a"
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "yy/mm/dd"
        
        let startTimeToEndTime = "\(timeFormatter.string(from: start))-\(timeFormatter.string(from: end))"
        
        let date: String
        let startDate = dayFormatter.string(from: start)
        let endDate = dayFormatter.string(from: end)
        
        if startDate == endDate {
            date = startDate
        } else {
            date = "\(startDate)-\(endDate)"
        }
        
        return (date: date, startToEnd: startTimeToEndTime)
    }
    
    static func simpleDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        formatter.timeStyle = .medium
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.dateFormat = "hh:mm a MMMM dd, yyyy"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
}
