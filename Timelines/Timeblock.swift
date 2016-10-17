//
//  Timeblock.swift
//  Timelines
//
//  Created by Rodney Sampson on 10/13/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

class Timeblock {
    var start: Date
    var end: Date
    var duration: TimeInterval {
        return end.timeIntervalSince(start)
    }
    
    init?(json: [String : Any]) {
        guard let start = DateTools.localTimeFormatter.date(from: (json[JSONKeys.EventRequest.start.key] as? String)!) else {
            return nil
        }
        
        guard let end = DateTools.localTimeFormatter.date(from: (json[JSONKeys.EventRequest.end.key] as? String)!) else {
            return nil
        }
    
        self.start = start
        self.end = end
    }
    
    init(start: Date, end: Date) {
        self.start = start
        self.end = end
    }
}

extension Timeblock {
    
    /// Returns start time as GMT in ISO format
    func startAsGMT() -> String {
        return DateTools.gmtFormatter.string(from: start)
    }
    
    /// Returns end time as GMT in ISO format
    func endAsGMT() -> String {
        return DateTools.gmtFormatter.string(from: end)
    }
    
}

extension Timeblock: Comparable {
    
    public static func ==(lhs: Timeblock, rhs: Timeblock) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
    
    public static func <(lhs: Timeblock, rhs: Timeblock) -> Bool {
        return lhs.end < rhs.start
    }
    
    public static func >(lhs: Timeblock, rhs: Timeblock) -> Bool {
        return lhs.start > rhs.end
    }
    
}
