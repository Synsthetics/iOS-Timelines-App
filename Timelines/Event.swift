//
//  Event.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/10/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

class Event: Timeblock {
    var id: Int
    var name: String
    var owner: User
    var attendees: [User]?
    var details: String
    var timezoneCreatedIn: String
    
    init(id: Int, name: String, details: String, start: Date, end: Date, timezoneCreatedIn: String, owner: User) {
        self.id = id
        self.name = name
        self.details = details
        self.timezoneCreatedIn = timezoneCreatedIn
        self.owner = owner
        super.init(start: start, end: end)
    }
    
    convenience init?(json: [String : Any]) {
        guard let id = json[JSONKeys.EventRequest.id.key]  as? Int else {
            return nil
        }
        
        guard let name = json[JSONKeys.EventRequest.name.key] as? String else {
            return nil
        }

        guard let details = json[JSONKeys.EventRequest.details.key]  as? String else {
            return nil
        }
        
        guard let timezoneCreatedIn = json[JSONKeys.EventRequest.timeZoneCreatedIn.key] as? String else {
            return nil
        }
        
        guard let start = DateTools.localTimeFormatter.date(from: (json[JSONKeys.EventRequest.start.key] as? String)!) else {
            return nil
        }
        
        guard let end = DateTools.localTimeFormatter.date(from: (json[JSONKeys.EventRequest.end.key] as? String)!) else {
            return nil
        }
        
        guard let owner = User(json: (json[JSONKeys.EventRequest.owner.key] as? [String: Any])!) else {
            return nil
        }
        
        self.init(id: id, name: name, details: details, start: start, end: end, timezoneCreatedIn: timezoneCreatedIn, owner: owner)
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
    
}
