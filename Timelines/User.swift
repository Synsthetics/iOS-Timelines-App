//
//  User.swift
//  Timeline
//
//  Created by Daniel Kwolek on 10/7/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

class User {
    var id: Int?
    var username: String
    var email: String? = nil
    var contacts: [String] = []
    
    init(id: Int, username: String, email: String?) {
        self.id = id
        self.username = username
        self.email = email
    }
    
    convenience init?(json: [String: Any]) {
        guard let username = json["username"] as? String, let id = json["id"] as? Int else {
            return nil
        }
        
        let email = json["email"] as? String
        self.init(id: id, username: username, email: email)

    }
}
