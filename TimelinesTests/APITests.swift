//
//  TimelinesTests.swift
//  TimelinesTests
//
//  Created by Daniel Kwolek on 10/10/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import XCTest
@testable import Timelines

class APITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testEndpoints() {
        XCTAssert(API.Endpoint.login.rawValue == "/login")
        XCTAssert(API.Endpoint.register.rawValue == "/register")
        XCTAssert(API.Endpoint.addEvent.rawValue == "/addEvent")
        XCTAssert(API.Endpoint.requestFriend.rawValue == "/requestFriend")
        XCTAssert(API.Endpoint.confirmFriend.rawValue == "/confirmFriend")
    }
    
    
    func testAuthResponseStruct() {
        let jsonOne = ["username" : "TestUser10", "email" : "TestEmail10", "id" : 10] as [String : Any]
        let jsonTwo = ["errorMessage" : "This is another error message"]
        let jsonThree = ["AODIJqfqef" : "jaoewjfjf"]
        
        XCTAssertNotNil(jsonOne)
        XCTAssertNotNil(jsonTwo)
        XCTAssertNotNil(jsonThree)
        
        let testErrorResponse = API.AuthResponse.init(errorMessage: "This is an error message")
        let testErrorResponseTwo = API.AuthResponse.init(json: jsonTwo)
        let testUserResponse = API.AuthResponse.init(json: jsonOne )
        let invalidAuthResponse = API.AuthResponse.init(json: jsonThree)
        
        XCTAssertNil(invalidAuthResponse.errorMessage)
        XCTAssertNil(invalidAuthResponse.user)
        
        XCTAssertNil(testErrorResponse.user)
        XCTAssert(testErrorResponse.errorMessage == "This is an error message")
        
        XCTAssertNil(testErrorResponseTwo.user)
        XCTAssert(testErrorResponseTwo.errorMessage == "This is another error message")
        
        XCTAssertNil(testUserResponse.errorMessage)
        XCTAssert(testUserResponse.user?.email == "TestEmail10")
        XCTAssert(testUserResponse.user?.username == "TestUser10")
        XCTAssert(testUserResponse.user?.id == 10)
    }
    
    func testRequestFriendResponseStruct() {
        let jsonOne = ["sent" : true]
        let jsonTwo =  ["sent"  : false]
        let jsonThree = ["sent" : true, "errorMessage" : "There was some weird error but it worked"] as [String : Any]
        let jsonFour = ["sent" : false, "errorMessage" : "Something went wrong"] as [String : Any]
        let jsonFive = ["fpeoaifjwpf" : "Oifjqoeif"]
        
        let testSentResponseTrue = API.RequestFriendResponse.init(json: jsonOne)
        let testSentResponseFalse = API.RequestFriendResponse.init(json: jsonTwo)
        let testSentResponseTrueWithError = API.RequestFriendResponse.init(json: jsonThree)
        let testSentResponseFalseWithError = API.RequestFriendResponse.init(json: jsonFour)
        let testInvalidResponse = API.RequestFriendResponse.init(json: jsonFive)
        
        XCTAssertNil(testSentResponseTrue.errorMessage)
        XCTAssertNotNil(testSentResponseTrue.sent)
        XCTAssertTrue(testSentResponseTrue.sent!)
        
        XCTAssertNil(testSentResponseFalse.errorMessage)
        XCTAssertNotNil(testSentResponseFalse.sent)
        XCTAssertFalse(testSentResponseFalse.sent!)
        
        XCTAssertNotNil(testSentResponseTrueWithError.errorMessage)
        XCTAssert(testSentResponseTrueWithError.errorMessage == "There was some weird error but it worked")
        XCTAssertNotNil(testSentResponseTrueWithError.sent)
        XCTAssertTrue(testSentResponseTrueWithError.sent!)
        
        XCTAssertNotNil(testSentResponseFalseWithError.errorMessage)
        XCTAssert(testSentResponseFalseWithError.errorMessage == "Something went wrong")
        XCTAssertNotNil(testSentResponseFalseWithError.sent)
        XCTAssertFalse(testSentResponseFalseWithError.sent!)
        
        XCTAssertNil(testInvalidResponse.errorMessage)
        XCTAssertNil(testInvalidResponse.sent)
    }
    
    func testAddEventResponseStruct() {
        
        let jsonOne = ["created" : true]
        let jsonTwo =  ["created"  : false]
        let jsonThree = ["created" : true, "errorMessage" : "There was some weird error but it worked"] as [String : Any]
        let jsonFour = ["created" : false, "errorMessage" : "Something went wrong"] as [String : Any]
        let jsonFive = ["fpeoaifjwpf" : "Oifjqoeif"]
        
        let testCreatedResponseTrue = API.AddEventResponse.init(json: jsonOne)
        let testCreatedResponseFalse = API.AddEventResponse.init(json: jsonTwo)
        let testCreatedResponseTrueWithError = API.AddEventResponse.init(json: jsonThree)
        let testCreatedResponseFalseWithError = API.AddEventResponse.init(json: jsonFour)
        let testInvalidResponse = API.AddEventResponse.init(json: jsonFive)
        
        XCTAssertNil(testCreatedResponseTrue.errorMessage)
        XCTAssertNotNil(testCreatedResponseTrue.created)
        XCTAssertTrue(testCreatedResponseTrue.created!)
        
        XCTAssertNil(testCreatedResponseFalse.errorMessage)
        XCTAssertNotNil(testCreatedResponseFalse.created)
        XCTAssertFalse(testCreatedResponseFalse.created!)
        
        XCTAssertNotNil(testCreatedResponseTrueWithError.errorMessage)
        XCTAssert(testCreatedResponseTrueWithError.errorMessage == "There was some weird error but it worked")
        XCTAssertNotNil(testCreatedResponseTrueWithError.created)
        XCTAssertTrue(testCreatedResponseTrueWithError.created!)
        XCTAssertNotNil(testCreatedResponseFalseWithError.errorMessage)
        XCTAssert(testCreatedResponseFalseWithError.errorMessage == "Something went wrong")
        XCTAssertNotNil(testCreatedResponseFalseWithError.created)
        XCTAssertFalse(testCreatedResponseFalseWithError.created!)
        
        XCTAssertNil(testInvalidResponse.errorMessage)
        XCTAssertNil(testInvalidResponse.created)
    }
    
    func testURLCreation() {
        
    }
    
    
}
