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
    
    init(username: String, email: String?) {
        self.username = username
        self.email = email
    }
    
    convenience init?(json: [String: Any]) {
        guard let username = json["username"] as? String else {
            return nil
        }
        
        let email = json["email"] as? String
        self.init(username: username, email: email)
    }
}
