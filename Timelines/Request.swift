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
}

extension Request {
    func json() -> Data? {
        return try? JSONSerialization.data(withJSONObject: dictionary(), options: [])
    }
}

struct RegisterRequest: Request {
    let email: String
    let username: String
    let password: String
    
    func dictionary() -> [String: Any] {
        let data: [String: Any] = [
            JSONKeys.RegisterRequest.email.key: email,
            JSONKeys.RegisterRequest.username.key: username,
            JSONKeys.RegisterRequest.password.key: password
        ]
        
        return data
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
        let data = [
            JSONKeys.RegisterRequest.username.key: username,
            JSONKeys.RegisterRequest.password.key: password
        ]

        return data
    }
    
}

struct FriendRequest: Request {
    var contactor: User
    var contactee: User
    
    init(contactor: User, contactee: User) {
        self.contactor = contactor
        self.contactee = contactee
    }
    
    func dictionary() -> [String: Any] {
        let data = [
            JSONKeys.FriendRequest.contactor.key: contactor.id,
            JSONKeys.FriendRequest.contactee.key: contactee.id
        ]
        
        return data
    }
    
}

struct AcceptFriendRequest: Request {
    var accept: Bool
    var username: String?
    
    init(accept: Bool, user: User?) {
        self.accept = accept
        self.username = user?.username
    }
    
    func dictionary() -> [String: Any] {
        let data = [
            JSONKeys.AcceptFriend.accept.key: accept,
            JSONKeys.AcceptFriend.username.key: username
        ] as [String : Any]
        
        return data
    }
    
}
