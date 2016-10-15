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
        case id = "id"
        case name = "name"
        case start = "startDate"
        case end = "endDate"
        case owner = "owner"
        case details = "details"
        case timeZoneCreatedIn = "timezoneCreatedIn"
        
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
