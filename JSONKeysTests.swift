//
//  JSONKeysTests.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/14/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import XCTest

@testable import Timelines

class JSONKeysTests: XCTestCase {
    
    func testRegisterRequestEnum() {
        XCTAssert(JSONKeys.RegisterRequest.email.rawValue == "email")
        XCTAssert(JSONKeys.RegisterRequest.username.rawValue == "username")
        XCTAssert(JSONKeys.RegisterRequest.password.rawValue == "password")
    }
    
    

}
