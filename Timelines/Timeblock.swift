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
