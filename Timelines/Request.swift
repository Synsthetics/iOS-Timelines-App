//
//  Request.swift
//  Timeline
//
//  Created by Princess Sampson on 10/9/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

protocol Request {
    func dictionary() -> [String: Any]
    func json() -> Data?
}

struct RegisterRequest: Request {
    let email: String
    let username: String
    let password: String
    
    func dictionary() -> [String: Any] {
        let data: [String: Any] = [
            JSONKeys.User.email.key:  email,
            JSONKeys.User.username.key: username,
            JSONKeys.User.password.key: password
        ]
        
        return data
    }
    
    func json() -> Data? {
        return try? JSONSerialization.data(withJSONObject: dictionary(), options: [])
    }
}

struct LoginRequest: Request {
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func dictionary() -> [String: Any] {
        let data: [String: Any] = [
            JSONKeys.User.username.key: username,
            JSONKeys.User.password.key: password
        ]
        
        return data
    }
    
    func json() -> Data? {
        return try? JSONSerialization.data(withJSONObject: dictionary(), options: [])
    }
}

struct AddEventRequest: Request  {
    let name: String
    let start: String
    let end: String
    let owner: User
    let details: String
    let timeZoneCreatedIn: String
    let isPrivate: Bool
    
    func dictionary() -> [String: Any] {
        let data: [String: Any] = [
            JSONKeys.Event.name.key: name,
            JSONKeys.Event.start.key: start,
            JSONKeys.Event.end.key: end,
            JSONKeys.Event.owner.key: [
                JSONKeys.User.username.key: owner.username
            ],
            JSONKeys.Event.details.key: details,
            JSONKeys.Event.timeZoneCreatedIn.key: timeZoneCreatedIn,
            JSONKeys.Event.isPrivate.key: isPrivate
        ]
        
        return data
    }
    
    func json() -> Data? {
        return try? JSONSerialization.data(withJSONObject: dictionary(), options: [])
    }
}

struct EditEventRequest: Request  {
    let id: Int
    let name: String
    let start: String
    let end: String
    let owner: User
    let details: String
    let timeZoneCreatedIn: String
    let isPrivate: Bool
    
    func dictionary() -> [String: Any] {
        let data: [String: Any] = [
            JSONKeys.Event.id.key : id,
            JSONKeys.Event.name.key: name,
            JSONKeys.Event.start.key: start,
            JSONKeys.Event.end.key: end,
            JSONKeys.Event.owner.key: [
                JSONKeys.User.username.key: owner.username
            ],
            JSONKeys.Event.details.key: details,
            JSONKeys.Event.timeZoneCreatedIn.key: timeZoneCreatedIn,
            JSONKeys.Event.isPrivate.key: isPrivate
        ]
        
        return data
    }
    
    func json() -> Data? {
        return try? JSONSerialization.data(withJSONObject: dictionary(), options: [])
    }
}

struct EventsRequest: Request {
    let username: String
    
    func dictionary() -> [String: Any] {
        let data: [String: Any] = [
            JSONKeys.User.username.key: username
        ]
        
        return data
    }
    
    func json() -> Data? {
        return try? JSONSerialization.data(withJSONObject: dictionary(), options: [])
    }
}

struct MergeTimelinesRequest: Request {
    let usernames: [String]
    
    func dictionary() -> [String: Any] {
        return [:]
    }
    
    func array() -> [[String: Any]] {
        var users = [[String: Any]]()
        
        for username in usernames {
            let user = [
                JSONKeys.User.username.key: username
            ]
            
            users.append(user)
        }
        
        return users
    }
    
    func json() -> Data? {
        return try? JSONSerialization.data(withJSONObject: array(), options: [])
    }
}

struct FriendRequest: Request {
    var sender: String
    var reciever: String
    
    init(sender: String, reciever: String) {
        self.sender = sender
        self.reciever = reciever
    }
    
    func dictionary() -> [String: Any] {
        let data: [String: Any] = [
            JSONKeys.FriendRequest.sender.key: [
                JSONKeys.User.username.key: sender
            ],
            JSONKeys.FriendRequest.reciever.key: [
                JSONKeys.User.username.key: reciever
            ]
        ]
        
        return data
    }
    
    func json() -> Data? {
        return try? JSONSerialization.data(withJSONObject: dictionary(), options: [])
    }
}

struct AcceptOrDenyContactRequest: Request {
    var id: Int
    var accepted: Bool
    
    func dictionary() -> [String: Any] {
        let data: [String: Any] = [
            JSONKeys.FriendRequest.id.key: id,
            JSONKeys.GetContacts.accepted.key: accepted
        ]
        
        return data
    }
    
    func json() -> Data? {
        return try? JSONSerialization.data(withJSONObject: dictionary(), options: [])
    }
}

struct ContactsRequest: Request {
    var username: String
    
    func dictionary() -> [String: Any] {
        let data: [String: Any] = [
            JSONKeys.User.username.key: username
        ]
        
        return data
    }
    
    func json() -> Data? {
        return try? JSONSerialization.data(withJSONObject: dictionary(), options: [])
    }
}
