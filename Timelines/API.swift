//
//  API.swift
//  Timeline
//
//  Created by Princess Sampson on 10/9/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

/// Encapsulates webservice base URL, and exposes methods for getting session-ready URLRequest instances
struct API {
    fileprivate static let baseURL = "http://synesthetictimelines.herokuapp.com"
    static let queue: OperationQueue = OperationQueue()
    static let session = URLSession.shared
    
    /// Encapsulates webservice endpoints.
    enum Endpoint: String {
        case login = "/login"
        case register = "/register"
        case addEvent = "/addEvent"
        case requestFriend = "/requestFriend"
        case confirmFriend = "/confirmFriend"
    }
    
    struct AuthResponse {
        var user: User?
        var errorMessage: String?
        
        init(json: [String: Any]) {
            if let user = User(json: json) {
                self.user = user
            } else if let errorMessage = json["errorMessage"] as? String {
                self.errorMessage = errorMessage
            }
        }
        
        init(errorMessage: String) {
            self.errorMessage = errorMessage
        }
        
    }
    
    struct RequestFriendResponse {
        var sent: Bool?
        var errorMessage: String?
        
        init(json: [String: Any]) {
            self.sent = json["sent"] as? Bool
            self.errorMessage = json["errorMessage"] as? String
        }
        
        init(errorMessage: String) {
            self.errorMessage = errorMessage
        }
    }
    
    struct AddEventResponse {
        var event: Event?
        var errorMessage: String?
        
        init(json: [String: Any]) {
            if let event = Event(json: json) {
                self.event = event
            } else {
                self.errorMessage = json["errorMessage"] as? String
            }
        }
        
        init(errorMessage: String) {
            self.errorMessage = errorMessage
        }
    }
    
}

extension API {
    
    /// Returns a URLRequest object ready for use with URLSession.dataTask(with:)
    /// - parameter endpoint: The desired webservice endpoint
    /// - parameter body: Instance to serialize and add to request body
    /// - parameter method: HTTP method for this request
    static func request(to endpoint: API.Endpoint, with body: Request, how method: String) -> URLRequest {
        let destination = url(for: endpoint)
        var request = URLRequest(url: destination)
        
        addJSONHeaders(to: &request)
        
        request.httpMethod = method
        request.httpBody = body.json()
        
        return request
    }
    
    /// URL object for webservice endpoint
    private static func url(for endpoint: API.Endpoint) -> URL {
        let resource = baseURL.appending(endpoint.rawValue)
        let url = URL(string: resource)
        
        return url!
    }
    
    /// Set provided request instance's Content-Type and Accept headers to application/json
    /// - parameter request: The request to add the headers to
    private static func addJSONHeaders(to request: inout URLRequest) {
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
    }
    
}

extension API {
    
    static func register(body: RegisterRequest, with completion: @escaping (AuthResponse) -> (Void)) {
        let request = API.request(to: .register, with: body, how: "POST")
        
        let registerTask = API.session.dataTask(with: request) { (optData, optResponse, optError) in
            var authResponse: AuthResponse
            
            if let data = optData, let responseJSON = JSONTools.dataToDictionary(data) {
                authResponse = AuthResponse(json: responseJSON)
            } else {
                authResponse = AuthResponse(errorMessage: "Could not deserialize server response")
            }
            
            completion(authResponse)
        }
        
        registerTask.resume()
    }
    
}

extension API {
    
    static func login(body: LoginRequest, with completion: @escaping (AuthResponse) -> (Void)) {
        let request = API.request(to: .login, with: body, how: "POST")
        
        let task = API.session.dataTask(with: request) { (optData, optResponse, optError) in
            var authResponse: AuthResponse
            
            if let data = optData, let responseJSON = JSONTools.dataToDictionary(data) {
                authResponse = AuthResponse(json: responseJSON)
            } else {
                authResponse = AuthResponse(errorMessage: "Could not deserialize server response")
            }
            
            completion(authResponse)
        }
        
        task.resume()
    }
    
}

extension API {
    
    static func addEvent(body: AddEventRequest, with completion: @escaping (AddEventResponse) -> (Void)) {
        let request = API.request(to: .addEvent, with: body, how: "POST")
        
        let task = API.session.dataTask(with: request) { optData, optResponse, optError in
            var addEventResponse: AddEventResponse
            
            if let data = optData, let responseJSON = JSONTools.dataToDictionary(data) {
                addEventResponse = AddEventResponse(json: responseJSON)
            } else {
                addEventResponse = AddEventResponse(errorMessage: "Could not deserialize server response")
            }
            
            completion(addEventResponse)
            
        }
        task.resume()
    }
    
}

extension API {
    
    static func requestFriend(body: FriendRequest, with completion: @escaping (Bool) -> (Void)) {
        let request = API.request(to: .requestFriend, with: body, how: "POST")
        
        let task = API.session.dataTask(with: request) { optData, optResponse, optError in
            var friendRequestRepsonse: RequestFriendResponse
            
            if let data = optData, let responseJSON = JSONTools.dataToDictionary(data) {
                friendRequestRepsonse = RequestFriendResponse(json: responseJSON)
            } else {
                friendRequestRepsonse = RequestFriendResponse(errorMessage: "Could not deserialize server response")
            }
            
            completion(friendRequestRepsonse.sent!)
        }
        task.resume()
    }
    
    static func friend(body: AcceptFriendRequest, with completion: @escaping (User) -> (Void)) {
        let request = API.request(to: .confirmFriend, with: body, how: "POST")
        
        let task = API.session.dataTask(with: request) { optData, optResponse, optError in
            
        }
        task.resume()
    }
    
}


