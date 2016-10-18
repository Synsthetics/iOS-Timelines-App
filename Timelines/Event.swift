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
    
    override init?(json: [String : Any]) {
        guard let id = json[JSONKeys.Event.id.key]  as? Int else {
            return nil
        }
        
        guard let name = json[JSONKeys.Event.name.key] as? String else {
            return nil
        }

        guard let details = json[JSONKeys.Event.details.key]  as? String else {
            return nil
        }
        
        guard let timezoneCreatedIn = json[JSONKeys.Event.timeZoneCreatedIn.key] as? String else {
            return nil
        }
        
        guard let owner = User(json: (json[JSONKeys.Event.owner.key] as? [String: Any])!) else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.details = details
        self.timezoneCreatedIn = timezoneCreatedIn
        self.owner = owner
        
        super.init(json: json)
    }
    
    init(id: Int, name: String, details: String, start: Date, end: Date, timezoneCreatedIn: String, owner: User) {
        self.id = id
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
    
}
