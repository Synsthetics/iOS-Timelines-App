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
    var details: String
    var owner: User
    var timezoneCreatedIn: String
    var isPrivate: Bool
    var attendees: [User]?
    
    override init?(json: [String : Any]) {
        guard let id = json[JSONKeys.Event.id.key]  as? Int,
            let details = json[JSONKeys.Event.details.key]  as? String,
            let timezoneCreatedIn = json[JSONKeys.Event.timeZoneCreatedIn.key] as? String,
            let owner = User(json: (json[JSONKeys.Event.owner.key] as? [String: Any])!) else {
            return nil
        }
        
        guard let isPrivate = json[JSONKeys.Event.isPrivate.key] as? Bool else {
            return nil
        }
        
        self.id = id
        self.details = details
        self.timezoneCreatedIn = timezoneCreatedIn
        self.owner = owner
        self.isPrivate = isPrivate
        
        super.init(json: json)
    }
    
    init(id: Int, name: String, details: String, start: Date, end: Date, timezoneCreatedIn: String, owner: User, isPrivate: Bool) {
        self.id = id
        self.details = details
        self.owner = owner
        self.timezoneCreatedIn = timezoneCreatedIn
        self.isPrivate = isPrivate
        
        super.init(name: name, start: start, end: end)
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
