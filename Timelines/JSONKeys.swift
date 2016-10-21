//
//  JSONKeys.swift
//  Timeline
//
//  Created by Princess Sampson on 10/9/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

enum JSONKeys {
    
    enum User: String {
        case username = "username"
        case email = "email"
        case password = "password"
        
        var key: String {
            return self.rawValue
        }
    }
    
    enum Event: String {
        case id = "id"
        case name = "name"
        case start = "startDate"
        case end = "endDate"
        case owner = "owner"
        case details = "details"
        case timeZoneCreatedIn = "timezoneCreatedIn"
        case isPublic = "privacyStatus"
        
        var key: String {
            return self.rawValue
        }
    }
    
    enum FriendRequest: String {
        case id = "id"
        case sent = "sent"
        case sender = "sender"
        case reciever = "receiver"
        
        var key: String {
            return self.rawValue
        }
    }
    
    enum GetContacts: String {
        case accepted = "accepted"
        
        var key: String {
            return self.rawValue
        }
    }
    
    enum ResponseKeys: String {
        case errorMessage = "errorMessage"
        
        var key: String {
            return self.rawValue
        }
    }
    
}
