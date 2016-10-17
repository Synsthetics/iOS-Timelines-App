//
//  Request.swift
//  Timeline
//
//  Created by Princess Sampson on 10/9/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

protocol Request {
    func dictionary() -> [String : Any]
    
    func json() -> Data?
}

struct RegisterRequest: Request {
    let email: String
    let username: String
    let password: String
    
    func dictionary() -> [String : Any] {
        let data: [String : Any] = [
            JSONKeys.RegisterRequest.email.key :  email,
            JSONKeys.RegisterRequest.username.key : username,
            JSONKeys.RegisterRequest.password.key : password
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
    
    func dictionary() -> [String : Any] {
        let data: [String: Any] = [
            JSONKeys.RegisterRequest.username.key : username,
            JSONKeys.RegisterRequest.password.key : password
        ]
        
        return data
    }
    
    func json() -> Data? {
        return try? JSONSerialization.data(withJSONObject: dictionary(), options: [])
    }
    
}

struct FriendRequest: Request {
    var contactor: User
    var contactee: User
    
    init(contactor: User, contactee: User) {
        self.contactor = contactor
        self.contactee = contactee
    }
    
    func dictionary() -> [String : Any] {
        let data: [String : Any] = [
            JSONKeys.FriendRequest.contactor.key : contactor.id,
            JSONKeys.FriendRequest.contactee.key : contactee.id
        ]
        
        return data
    }
    
    func json() -> Data? {
        return try? JSONSerialization.data(withJSONObject: dictionary(), options: [])
    }
    
}

struct AcceptFriendRequest: Request {
    var accept: Bool
    var username: String
    
    func dictionary() -> [String : Any] {
        let data: [String : Any] = [
            JSONKeys.AcceptFriend.accept.key : accept,
            JSONKeys.AcceptFriend.username.key : username
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
    
    func dictionary() -> [String : Any] {
        let data: [String : Any] = [
            JSONKeys.EventRequest.name.key : name,
            JSONKeys.EventRequest.start.key : start,
            JSONKeys.EventRequest.end.key : end,
            JSONKeys.EventRequest.owner.key : [
                JSONKeys.RegisterRequest.username.key : owner.username
            ],
            JSONKeys.EventRequest.details.key : details,
            JSONKeys.EventRequest.timeZoneCreatedIn.key : timeZoneCreatedIn
        ]
        
        return data
    }
    
    func json() -> Data? {
        return try? JSONSerialization.data(withJSONObject: dictionary(), options: [])
    }
    
}

struct EventsRequest: Request {
    var username: String
    
    func dictionary() -> [String : Any] {
        let data: [String : Any] = [
            JSONKeys.RegisterRequest.username.key : username
        ]
        
        return data
    }
    
    func json() -> Data? {
        return try? JSONSerialization.data(withJSONObject: dictionary(), options: [])
    }
    
}

struct MergeTimelinesRequest: Request {
    var usernames: [String]
    
    func dictionary() -> [String : Any] {
        return [:]
    }
    
    func array() -> [[String : Any]] {
        var users = [[String : Any]]()
        
        for username in usernames {
            let user = [
                JSONKeys.RegisterRequest.username.key : username
            ]
            
            users.append(user)
        }
        
        return users
    }
    
    func json() -> Data? {
        return try? JSONSerialization.data(withJSONObject: array(), options: [])
    }
    
}
