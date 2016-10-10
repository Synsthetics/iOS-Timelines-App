//
//  User.swift
//  Timeline
//
//  Created by Daniel Kwolek on 10/7/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

class User {
    var username: String
    var email: String? = nil
    var contacts: [String] = []
    
    init(username: String, email: String, contacts: [String]) {
        self.username = username
        self.email = email
        self.contacts = contacts
    }
    
    convenience init?(json: [String: Any]) {
        guard let username = json["username"] as? String,
              let email = json["email"] as? String,
              let contacts = json["contacts"] as? [String] else {
            return nil
        }
        self.init(username: username, email: email, contacts: contacts)
    }
}
