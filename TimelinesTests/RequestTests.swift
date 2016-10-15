//
//  RequestTests.swift
//  Timeline
//
//  Created by Princess Sampson on 10/9/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import XCTest
@testable import Timelines

class RequestTests: XCTestCase {
    
    func testRegisterRequestToDictionary() {
        let request = RegisterRequest(email: "foo@bar.com", username: "foobarbaz", password: "f!o!o!")
        
        let expected: [String: Any] = [
            "email" : "foo@bar.com",
            "username" : "foobarbaz",
            "password" : "f!o!o!"
        ]
        
        let actual = request.dictionary()
        
        XCTAssertEqual(expected as NSDictionary, actual as NSDictionary)
    }
    
//    func testAddEventRequestToDictionary() {
//        let request = AddEventRequest(name: "Civil war", start: "2016-05-06T00:15:00Z", end: "2016-05-06T02:15:00Z", owner: 0, details: "Early screening of new Cap movie", timeZoneCreatedIn: "EDT")
//        
//        let expected: [String: Any] = [
//            "name" : "Civil war",
//            "start" : "2016-05-06T00:15:00Z",
//            "end" : "2016-05-06T02:15:00Z",
//            "owner" : 0,
//            "details": "Early screening of new Cap movie",
//            "timeZoneCreatedIn": "EDT"
//        ]
//        
//        let actual = request.dictionary()
//        
//        XCTAssertEqual(expected as NSDictionary, actual as NSDictionary)
//    }
}
