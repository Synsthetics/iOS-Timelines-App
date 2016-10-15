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
    
    convenience init?(json: [String : Any]) {
        guard let name = json["name"]  as? String,
            let details = json["details"]  as? String,
            let timezoneCreatedIn = json["timezoneCreatedIn"] as? String else {
                return nil
        }
        
        guard let start = DateTools.localTimeFormatter.date(from: (json["startDate"] as? String)!),
              let end = DateTools.localTimeFormatter.date(from: (json["endDate"] as? String)!) else {
                return nil
        }
        
        guard let owner = User(json: (json["owner"] as? [String: Any])!) else {
            return nil
        }
        
        self.init(name: name, details: details, start: start, end: end, timezoneCreatedIn: timezoneCreatedIn, owner: owner)
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
