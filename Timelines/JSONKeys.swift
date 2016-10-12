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
        case contactor
        case contactee
        
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
    
}
