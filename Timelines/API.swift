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
        case events = "/events"
        case addEvent = "/addEvent"
        case mergeTimelines = "/mergeTimelines"
        case requestContact = "/requestContact"
        case confirmContact = "/confirmContact"
        case contacts = "/contacts"
        case pendingContacts = "/pendingContacts"
        case contactRequests = "/contactRequests"
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
        
        let registerTask = API.session.dataTask(with: request) { optData, optResponse, optError in
            var authResponse: AuthResponse
            
            if let data = optData, let responseJSON = JSONTools.dictionary(from: data) {
                authResponse = AuthResponse(json: responseJSON)
            } else {
                authResponse = AuthResponse(errorMessage: "Could not deserialize server response")
            }
            
            completion(authResponse)
        }
        
        registerTask.resume()
    }
    
    static func login(body: LoginRequest, with completion: @escaping (AuthResponse) -> (Void)) {
        let request = API.request(to: .login, with: body, how: "POST")
        
        let task = API.session.dataTask(with: request) { optData, optResponse, optError in
            var authResponse: AuthResponse
            
            if let data = optData, let responseJSON = JSONTools.dictionary(from: data) {
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
    
    static func events(body: EventsRequest, with completion: @escaping (EventsResponse) -> (Void)) {
        let request = API.request(to: .events, with: body, how: "POST")
        
        let task = API.session.dataTask(with: request) { optData, optResponse, optError in
            var eventsResponse: EventsResponse?
            
            guard let data = optData else {
                eventsResponse = EventsResponse(errorMessage: "Could not deserialize server response")
                completion(eventsResponse!)
                return
            }
            
            if let responseJSON = JSONTools.arrayOfDictionaries(from: data) {
                eventsResponse = EventsResponse(json: responseJSON)
            } else if let responseJSON = JSONTools.dictionary(from: data) {
                eventsResponse = EventsResponse(errorMessage: responseJSON[JSONKeys.ResponseKeys.errorMessage.key] as! String)
            }
            
            completion(eventsResponse!)
        }
        task.resume()
    }
    
    static func addEvent(body: AddEventRequest, with completion: @escaping (AddEventResponse) -> (Void)) {
        let request = API.request(to: .addEvent, with: body, how: "POST")
        
        let task = API.session.dataTask(with: request) { optData, optResponse, optError in
            var addEventResponse: AddEventResponse
            
            if let data = optData, let responseJSON = JSONTools.dictionary(from: data) {
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
    
    static func mergeTimelines(body: MergeTimelinesRequest, with completion: @escaping (EventsResponse) -> (Void)) {
        let request = API.request(to: .mergeTimelines, with: body, how: "POST")
        
        let task = API.session.dataTask(with: request) { optData, optResponse, optError in
            var mergeTimelinesResponse: EventsResponse
            
            if let data = optData, let responseJSON = JSONTools.arrayOfDictionaries(from: data) {
                mergeTimelinesResponse = EventsResponse(json: responseJSON)
            } else {
                mergeTimelinesResponse = EventsResponse(errorMessage: "Could not deserialize server response")
            }
            
            completion(mergeTimelinesResponse)
        }
        task.resume()
        
    }
}

extension API {
    
    static func requestFriend(body: FriendRequest, with completion: @escaping (String) -> (Void)) {
        let request = API.request(to: .requestContact, with: body, how: "POST")
        
        let task = API.session.dataTask(with: request) { optData, optResponse, optError in
            var friendRequestResponse: RequestFriendResponse
            
            if let data = optData, let responseJSON = JSONTools.dictionary(from: data) {
                friendRequestResponse = RequestFriendResponse(json: responseJSON)
            } else {
                friendRequestResponse = RequestFriendResponse(errorMessage: "Could not deserialize server response")
            }
            
            completion(friendRequestResponse.message!)
        }
        task.resume()
    }
    
    static func acceptOrDenyContact(body: AcceptOrDenyContactRequest, with completion: @escaping (User) -> (Void)) {
        let request = API.request(to: .confirmContact, with: body, how: "POST")
        
        let task = API.session.dataTask(with: request) { optData, optResponse, optError in
            
            
            
        }
        task.resume()
    }
    
}

extension API {
    
    static func contacts(body: ContactsRequest, with completion: @escaping (ContactsResponse) -> (Void)) {
        let request = API.request(to: .contacts, with: body, how: "POST")
        
        let task = API.session.dataTask(with: request) { optData, optResponse, optError in
            var getContactsResponse: ContactsResponse?
            
            guard let data = optData else {
                getContactsResponse = ContactsResponse(errorMessage: "Could not deserialize server response")
                completion(getContactsResponse!)
                return
            }
            
            if let responseJSON = JSONTools.arrayOfDictionaries(from: data) {
                getContactsResponse = ContactsResponse(json: responseJSON)
            } else if let responseJSON = JSONTools.dictionary(from: data),
                let message = responseJSON[JSONKeys.ResponseKeys.errorMessage.key] as? String {
                getContactsResponse = ContactsResponse(errorMessage: message)
            } else {
                getContactsResponse = ContactsResponse(errorMessage: "Unexpected server response")
            }
            
            completion(getContactsResponse!)
        }
        task.resume()
    }
    
    static func pendingContacts(body: ContactsRequest, with completion: @escaping (PendingContactsResponse) -> (Void)) {
        let request = API.request(to: .pendingContacts, with: body, how: "POST")
        
        let task = API.session.dataTask(with: request) { optData, optResponse, optError in
            var pendingContactsResponse: PendingContactsResponse
            
            guard let data = optData else {
                pendingContactsResponse = PendingContactsResponse(errorMessage: "Could not deserialize server response")
                completion(pendingContactsResponse)
                return
            }
            
            if let responseJSON = JSONTools.arrayOfDictionaries(from: data) {
                pendingContactsResponse = PendingContactsResponse(json: responseJSON)
            } else if let responseJSON = JSONTools.dictionary(from: data),
                let message = responseJSON[JSONKeys.ResponseKeys.errorMessage.key] as? String {
                pendingContactsResponse = PendingContactsResponse(errorMessage: message)
            } else {
                pendingContactsResponse = PendingContactsResponse(errorMessage: "Unexpected server response")
            }
            
            completion(pendingContactsResponse)
        }
        task.resume()
    }
    
    static func contactRequests(body: ContactsRequest, with completion: @escaping (ContactRequestsResponse) -> (Void)) {
        let request = API.request(to: .contactRequests, with: body, how: "POST")
        
        let task = API.session.dataTask(with: request) { optData, optResponse, optError in
            let contactRequestsResponse: ContactRequestsResponse
            
            guard let data = optData else {
                contactRequestsResponse = ContactRequestsResponse(errorMessage: "Could not deserialize server response")
                completion(contactRequestsResponse)
                return
            }
            
            if let responseJSON = JSONTools.arrayOfDictionaries(from: data) {
                contactRequestsResponse = ContactRequestsResponse(json: responseJSON)
            } else if let responseJSON = JSONTools.dictionary(from: data),
                let message = responseJSON[JSONKeys.ResponseKeys.errorMessage.key] as? String {
                contactRequestsResponse = ContactRequestsResponse(errorMessage: message)
            } else {
                contactRequestsResponse = ContactRequestsResponse(errorMessage: "Unexpected server response")
            }
            
            completion(contactRequestsResponse)
        }
        task.resume()
    }
    
}
