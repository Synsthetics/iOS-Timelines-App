//
//  JSONKeys.swift
//  Timeline
//
//  Created by Princess Sampson on 10/9/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

enum JSONKeys {
    
    enum RegisterRequest: String {
        case email = "email"
        case username = "username"
        case password = "password"
        
        var key: String {
            return self.rawValue
        }
        
    }
    
    enum FriendRequest: String {
        case contactor = "contactor"
        case contactee = "contactee"
        
        var key: String {
            return self.rawValue
        }
    }
    
    enum AcceptFriend: String {
        case accept = "accept"
        case username = "username"
        
        var key: String {
            return self.rawValue
        }
    }
    
    enum EventRequest: String {
        case name = "name"
        case start = "start"
        case end = "end"
        case owner = "owner"
        case details = "details"
        case timeZoneCreatedIn = "timeZoneCreatedIn"
        
        var key: String {
            return self.rawValue
        }
    }
    
}
