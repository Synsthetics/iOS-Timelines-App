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

class UserStore {
    
    static var mainUser: User? {
        didSet {
            writeMainUserToSystem()
        }
    }
    static var friends = [(user: User, selected: Bool)]()
    static var selectedFriends: [String] = {
        var selected: [String] = friends.flatMap {
            if $0.selected {
                return $0.user.username
            } else {
                return nil
            }
        }
        
        guard let user = mainUser else {
            return selected
        }
        
        selected.insert(user.username, at: 0)
        return selected
    }()
    
    private static var userPlistPath: URL = {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let path = documentsDirectory?.appendingPathComponent("User.plist")
        return path!
    }()
    
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
    private static func writeMainUserToSystem() -> Bool {
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
