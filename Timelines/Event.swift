//
//  Event.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/10/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

class Event: Comparable {
    var id: Int?
    var name: String
    var start: Date
    var end: Date
    var duration: TimeInterval {
        return end.timeIntervalSince(start)
    }
    var owners: [User] = []
    var attendees: [User] = []
    var details: String
    
    init(name: String, details: String, start: Date, end: Date, owners: User...) {
        self.name = name
        self.details = details
        self.start = start
        self.end = end
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
