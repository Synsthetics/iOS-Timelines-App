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
    
    
}
