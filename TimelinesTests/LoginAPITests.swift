////
////  LoginAPITests.swift
////  Timeline
////
////  Created by Rodney Sampson on 10/9/16.
////  Copyright © 2016 Arcore. All rights reserved.
////
//
//import XCTest
//@testable import Timelines
//
//class LoginAPITests: XCTestCase {
//    
//    func testLoginResponseCreationForResponseUserJSON() {
//        let json: [String: Any] = [
//            "responseUser": [
//                "username": "userOne",
//                "email": "emailOne@timeline.com",
//                "contacts": ["userTwo", "userThree"]
//            ],
//            "errorMessage": ""
//        ]
//        
//        let response = LoginResponse(json: json)
//        let result = User(json: response!.responseUserJSON!)!
//        let expected = User(username: "userOne", email: "emailOne@timeline.com", contacts: ["userTwo", "userThree"])
//        
//        XCTAssert(result.username == expected.username)
//        XCTAssert(result.email == expected.email)
//        XCTAssert(result.contacts == expected.contacts)
//    }
//    
//    func testLoginResponseCreationForErrorMessage() {
//        let json: [String: Any] = [
//            "responseUser": [],
//            "errorMessage": "login error"
//        ]
//        
//        let response = LoginResponse(json: json)
//        let result = response!.errorMessage
//        let expected = "login error"
//        
//        XCTAssert(result == expected)
//    }
//    
//}
