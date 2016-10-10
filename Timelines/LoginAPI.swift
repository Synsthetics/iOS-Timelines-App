//
//  LoginApi.swift
//  Timeline
//
//  Created by Daniel Kwolek on 10/7/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

internal struct LoginAPI { // merge into main api struct later
    static var base: URL = URL(string: "ask ben for base url")!
    static var session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    static let queue: OperationQueue = OperationQueue()
    
    static func login(with loginRequest: LoginRequest) throws -> LoginResult {
        let url = LoginAPI.url(forEndpoint: Method.login)
        let request = LoginAPI.configureRequest(url: url, withLoginRequest: loginRequest)
        
        var result: LoginResult? = nil
        LoginAPI.queue.addOperation {
            let task = LoginAPI.session.dataTask(with: request) { data, response, error in
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                    let response = LoginResponse(json: json!)
                    
                    if let user = User(json: (response?.responseUserJSON)!) {
                        result = LoginResult.success(user)
                    } else {
                        print("error=\(response?.errorMessage)")
                        throw error!
                    }
                } catch {
                    result = LoginResult.failure(error)
                }
            }
            task.resume()
        }
        return result!
    }
    
    fileprivate static func url(forEndpoint endpoint: Method) -> URL {
        let url = URL(string: LoginAPI.base.absoluteString + endpoint.getMethod())!
        return url
    }
    
    fileprivate static func configureRequest(url: URL, withLoginRequest loginRequest: LoginRequest) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = loginRequest.json()
        return request
    }
    
}

struct LoginRequest {
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func json() -> Data? {
        let json = ["username": username, "password": password]
        
        do {
            return try JSONSerialization.data(withJSONObject: json, options: [])
        } catch {
            return nil
        }
    }
    
}

struct LoginResponse {
    var responseUserJSON: [String: Any]?
    var errorMessage: String?
    
    init?(json: [String: Any]) {
        guard let responseUser = json["responseUser"] as? [String: Any], let errorMessage = json["errorMessage"] as? String? else {
            return nil
        }
        
        self.responseUserJSON = responseUser
        self.errorMessage = errorMessage
    }
    
}

enum LoginResult {
    case success(User)
    case failure(Error)
}

enum Method {
    case login
    
    func getMethod() -> String {
        switch self {
        case .login:
            return "/login.json"
        }
    }
    
}
