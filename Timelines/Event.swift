//
//  Event.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/10/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

class Event: Comparable {
    var start: Date
    var duration: TimeInterval
    var end: Date
    var owners: [User] = []
    var attendees: [User] = []
    
    init(start: Date, duration: TimeInterval, owners: User...) {
        self.start = start
        self.duration = duration
        self.end = Date(timeInterval: self.duration, since: self.start)
        self.owners = owners
    }
    
    init(start: Date, end: Date, owners: User...) {
        self.start = start
        self.end = end
        self.duration = self.end.timeIntervalSince(self.start)
        self.owners = owners
    }
    
    func conflicts(with event: Event) -> Bool {
        let absoluteNoConflicts = self < event || self > event
        
        if absoluteNoConflicts {
            return !absoluteNoConflicts
        }
        
        return true
    }
    
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
