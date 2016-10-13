//
//  Event.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/10/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

class Event: Timeblock {
    var id: Int?
    var name: String
    var owner: User
    var attendees: [User]?
    var details: String
    var timezoneCreatedIn: String
    
    init(name: String, details: String, start: Date, end: Date, timezoneCreatedIn: String, owner: User) {
        self.name = name
        self.details = details
        self.timezoneCreatedIn = timezoneCreatedIn
        self.owner = owner
        super.init(start: start, end: end)
    }
    
}

extension Event {
    
    func conflicts(with event: Event) -> Bool {
        let absoluteNoConflicts = self < event || self > event
        
        if absoluteNoConflicts {
            return !absoluteNoConflicts
        }
        
        return true
    }
    
    /// Returns start time as GMT in ISO format
    func startAsGMT() -> String {
        return DateTools.gmtFormatter.string(from: start)
    }
    
    /// Returns end time as GMT in ISO format
    func endAsGMT() -> String {
        return DateTools.gmtFormatter.string(from: end)
    }
}

extension Event: Comparable {
    
    public static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
    
    public static func <(lhs: Event, rhs: Event) -> Bool {
        return lhs.end < rhs.start
    }
    
    public static func >(lhs: Event, rhs: Event) -> Bool {
        return lhs.start > rhs.end
    }
    
}
