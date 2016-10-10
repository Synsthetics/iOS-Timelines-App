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
        
        let expected: [String: Any] = ["email": "foo@bar.com",
                        "username": "foobarbaz",
                        "password": "f!o!o!"]
        
        let actual = request.dictionary()
        
        XCTAssertEqual(expected as NSDictionary, actual as NSDictionary)
    }
}
