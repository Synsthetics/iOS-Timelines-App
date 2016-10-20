//
//  Response.swift
//  Timelines
//
//  Created by Rodney Sampson on 10/18/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

struct AuthResponse {
    var user: User?
    var errorMessage: String?
    
    init(json: [String: Any]) {
        if let user = User(json: json) {
            self.user = user
        } else if let errorMessage = json[JSONKeys.ResponseKeys.errorMessage.key] as? String {
            self.errorMessage = errorMessage
        }
    }
    
    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
}

struct AddEventResponse {
    var event: Event?
    var errorMessage: String?
    
    init(json: [String: Any]) {
        if let event = Event(json: json) {
            self.event = event
        } else {
            self.errorMessage = json[JSONKeys.ResponseKeys.errorMessage.key] as? String
        }
    }
    
    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
}

struct EventsResponse {
    var timeblocks: [Timeblock]?
    var errorMessage: String?
    
    init(json: [[String : Any]] ) {
        let deserialized: [Timeblock]? = json.flatMap {
            let currentID = $0[JSONKeys.Event.id.key] as? Int
            let currentName = $0[JSONKeys.Event.name.key] as? String
            
            if currentID == 0 && currentName == "timeblock" {
                return Timeblock(json: $0)
            } else {
                return Event(json: $0)
            }
        }
        
        if let timeblocks = deserialized {
            self.timeblocks = timeblocks
        }
    }
    
    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
}


struct RequestFriendResponse {
    var message: String?
    
    init(json: [String: Any]) {
        self.message = json[JSONKeys.ResponseKeys.errorMessage.key] as? String
    }
    
    init(errorMessage: String) {
        self.message = errorMessage
    }
}

struct ContactsResponse {
    var contacts: [String]?
    var errorMessage: String?
    
    init(json: [[String: Any]]) {
        let deserialized: [String]? = json.map {
            let users = $0
            var contact = users[JSONKeys.FriendRequest.reciever.key] as? [String : Any]
            
            if contact?[JSONKeys.User.username.key] as? String == UserStore.mainUser?.username {
                contact = users[JSONKeys.FriendRequest.sender.key] as? [String : Any]
            }
            
            let username = contact?[JSONKeys.User.username.key] as? String
            return username!
        }
        
        if let contacts = deserialized {
            self.contacts = contacts
        }
    }
    
    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
}

struct PendingContactsResponse {
    var pendingContacts: [String]?
    var errorMessage: String?
    
    init(json: [[String : Any]]) {
        let deserialized: [String]? = json.flatMap {
            let request = $0
            guard let receiver = request[JSONKeys.FriendRequest.reciever.key] as? [String : Any],
                let username = receiver[JSONKeys.User.username.key] as? String else {
                    return nil
            }
            
            return username
        }
        
        self.pendingContacts = deserialized
    }
    
    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
}

struct ContactRequestsResponse {
    var requests: [PendingContactRequest]?
    var errorMessage: String?
    
    init(json: [[String : Any]]) {
        let deserialized: [(username: String, requestID: Int)]? = json.flatMap {
            let request = $0
            guard let id = request[JSONKeys.FriendRequest.id.key] as? Int,
                let sender = request[JSONKeys.FriendRequest.sender.key] as? [String : Any],
                let username = sender[JSONKeys.User.username.key] as? String else {
                    return nil
            }
            
            return PendingContactRequest(username: username, requestID: id)
        }
        
        self.requests = deserialized
    }
    
    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
}
