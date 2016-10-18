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
        guard var start = DateTools.localTimeFormatter.date(from: (json[JSONKeys.Event.start.key] as? String)!) else {
            return nil
        }
        
        guard var end = DateTools.localTimeFormatter.date(from: (json[JSONKeys.Event.end.key] as? String)!) else {
            return nil
        }
        
        Timeblock.scrubToMinute(start: &start, end: &end)
        self.start = start
        self.end = end
    }
    
    init(start: Date, end: Date) {
        var newStart = start
        var newEnd = end
        Timeblock.scrubToMinute(start: &newStart, end: &newEnd)
        self.start = newStart
        self.end = newEnd
    }
    
    private static func scrubToMinute(start: inout Date, end: inout Date) {
        start = Date(timeIntervalSinceReferenceDate: floor((start.timeIntervalSinceReferenceDate / 60.0)) * 60)
        end = Date(timeIntervalSinceReferenceDate: floor((end.timeIntervalSinceReferenceDate / 60.0)) * 60)
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
