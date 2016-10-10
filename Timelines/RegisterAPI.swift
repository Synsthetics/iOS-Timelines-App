//
//  RegisterAPI.swift
//  Timeline
//
//  Created by Daniel Kwolek on 10/7/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

enum AuthResult {
    case success(User)
    case failure(Error, String)
}

enum RegisterError: Error {
    case couldNotRegisterUser
    case invalidJSONData
}

struct RegisterAPI {
    
    static func register(user: RegisterRequest, with completion: @escaping (AuthResult) -> (Void)) {
        let request = API.request(to: .register, with: user, how: "POST")
        
        let registerTask = API.session.dataTask(with: request) { (optData, optResponse, optError) in
            
            let result: AuthResult
            
            guard let data = optData,
                let responseJSON = JSONTools.dataToDictionary(data) else {
                    result = .failure(RegisterError.invalidJSONData, "Internal server error")
                    return
            }
            
            if let responseError = responseJSON["message"] as? String {
                result = .failure(RegisterError.couldNotRegisterUser, responseError)
                return
            }
            
            result = userInstance(from: responseJSON)
            
            completion(result)
        }
        
        registerTask.resume()
        
    }
    
    static func userInstance(from dictionary:[String: Any]) -> AuthResult {
        guard let user = User(json: dictionary) else {
            return .failure(RegisterError.invalidJSONData, "Couldn't create User")
        }
        
        return .success(user)
    }
    
}

