//
//  UserStore.swift
//  Timelines
//
//  Created by Rodney Sampson on 10/11/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

enum FetchUserResult {
    case success(User)
    case failure(Error)
}

typealias PendingContactRequest = (username: String, requestID: Int)

class UserStore {
    static var shouldPoll: Bool = false
    static var contacts = [(username: String, selected: Bool)]()
    static var pendingContacts = [String]()
    static var pendingRequests = [PendingContactRequest]()
    
    static var mainUser: User? {
        willSet(user) {
            writeMainUserToSystem()
            
            if user == nil {
                UserStore.shouldPoll = false
            } else {
                UserStore.shouldPoll = true
            }
        }
    }
    
    static var selectedContacts: [String] {
        var selected: [String] = contacts.flatMap {
            if $0.selected {
                return $0.username
            } else {
                return nil
            }
        }
        
        guard let user = mainUser else {
            return selected
        }
        
        selected.insert(user.username, at: 0)
        return selected
    }
    
    fileprivate static var userPlistPath: URL = {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let path = documentsDirectory?.appendingPathComponent("User.plist")
        return path!
    }()
    
}

extension UserStore {
    
    static func addContact(username: String) {
        let userFound: [String] = UserStore.contacts.flatMap {
            let contact = $0
            
            if username == contact.username {
                return username
            }
            
            return nil
        }
        
        if userFound.isEmpty {
            UserStore.contacts.append((username: username, selected: false))
        }
    }
    
    static func addPendingContact(username: String) {
        let userFound: [String] = UserStore.pendingContacts.flatMap {
            let contact = $0
            
            if username == contact {
                return username
            }
            
            return nil
        }
        
        if userFound.isEmpty {
            UserStore.pendingContacts.append(username)
        }
    }
    
    static func addPending(request: PendingContactRequest) {
        let userFound: [String] = UserStore.pendingRequests.flatMap {
            let contact = $0
            
            if request.username == contact.username  {
                return request.username
            }
            
            return nil
        }
        
        if userFound.isEmpty {
            UserStore.pendingRequests.append(request)
        }
    }
    
}

extension UserStore {
    
    static func fetchMainUserFromSystem(completion: (FetchUserResult) -> Void) {
        do {
            let data = try Data(contentsOf: userPlistPath)
            let userData = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String : Any]
            
            if let user = User(json: userData!) {
                completion(.success(user))
            }
            
        } catch {
            print("💜Could not fetch user because: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    @discardableResult
    fileprivate static func writeMainUserToSystem() -> Bool {
        guard let user = mainUser else {
            return false
        }
        
        let userData: [String : Any] = [
            "id" : user.id,
            "username" : user.username,
            "email" : user.email
        ]
        
        do {
            let plist = try PropertyListSerialization.data(fromPropertyList: userData, format: .xml, options: 0)
            try plist.write(to: userPlistPath)
        } catch {
            print("Could not cache user because: \(error)")
            return false
        }
        
        return true
    }
    
}
