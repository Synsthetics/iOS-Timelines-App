//
//  UserTests.swift
//  Timeline
//
//  Created by Daniel Kwolek on 10/7/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import XCTest
@testable import Timelines

class UserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testUserCreationWithDictionary() {
        let jsonPersonOne: [String : Any] = [
            "username": "personOne",
            "email": "emailOne@email.com",
            "contacts": ["personTwo"]
        ]
        
        let jsonPersonTwo: [String : Any] = [
            "username": "personTwo",
            "email": "emailTwo@email.com",
            "contacts": ["personOne"]
        ]
        
        let userOne = User(json: jsonPersonOne)
        
        let userTwo = User(json: jsonPersonTwo)
        
        XCTAssert(userOne!.username == "personOne")
        XCTAssert(userTwo!.username == "personTwo")
        
        XCTAssert(userOne!.email == "emailOne@email.com")
        XCTAssert(userTwo!.email == "emailTwo@email.com")
        
        XCTAssert(userOne!.contacts == ["personTwo"])
        XCTAssert(userTwo!.contacts == ["personOne"])
    }
    
}
