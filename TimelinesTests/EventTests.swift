////
////  EventTests.swift
////  Timelines
////
////  Created by Daniel Kwolek on 10/10/16.
////  Copyright © 2016 Arcore. All rights reserved.
////
//
//import XCTest
//@testable import Timelines
//
//class EventTests: XCTestCase {
//    
//    var calendar = Calendar(identifier: .gregorian)
//    var now = Date()
//    
//    var components: Set<Calendar.Component> = [.yearForWeekOfYear, .weekOfYear, .timeZone]
//    var currentDateComponents: DateComponents?
//    var startOfWeek: Date?
//    var secondsElasped: Int?
//    
//    var testDate1: Date?
//    var testDate2: Date?
//    var testDate3: Date?
//    var aram: Event?
//    var bots: Event?
//    var tt3: Event?
//    var sr5: Event?
//    
//    override func setUp() {
//        currentDateComponents = calendar.dateComponents(components, from: now)
//        startOfWeek = calendar.date(from: currentDateComponents!)!
//        secondsElasped = Int(now.timeIntervalSince(startOfWeek!) / 60)
//        
//        testDate1 = startOfWeek?.addingTimeInterval(5000)
//        testDate2 = testDate1?.addingTimeInterval(5000)
//        testDate3 = testDate2?.addingTimeInterval(5000)
//        
//        aram = Event(start: testDate1!, end: testDate2!)
//        bots = Event(start: testDate1!, end: testDate2!)
//        tt3 = Event(start: startOfWeek!, duration: 2000)
//        sr5 = Event(start: testDate3!, duration: 2000)
//    }
//    
//    func testEventEquality() {
//        XCTAssertEqual(aram, bots)
//    }
//    
//    func testEventInequality() {
//        XCTAssertNotEqual(aram, tt3)
//        XCTAssertNotEqual(aram, sr5)
//        XCTAssertNotEqual(bots, tt3)
//        XCTAssertNotEqual(bots, sr5)
//        XCTAssertNotEqual(tt3, sr5)
//    }
//    
//    func testEventLaterAndGreater() {
//        XCTAssertGreaterThan(aram!, tt3!)
//        XCTAssertGreaterThan(bots!, tt3!)
//        XCTAssertGreaterThan(sr5!, aram!)
//        XCTAssertGreaterThan(sr5!, bots!)
//        XCTAssertGreaterThan(sr5!, tt3!)
//    }
//    
//    func testEventIsEarlier() {
//        XCTAssertLessThan(tt3!, aram!)
//        XCTAssertLessThan(tt3!, bots!)
//        XCTAssertLessThan(tt3!, sr5!)
//        XCTAssertLessThan(aram!, sr5!)
//        XCTAssertLessThan(bots!, sr5!)
//    }
//    
//    func testEventConflicts() {
//        XCTAssertTrue(aram!.conflicts(with: bots!))
//        XCTAssertFalse(aram!.conflicts(with: sr5!))
//        XCTAssertFalse(aram!.conflicts(with: tt3!))
//        XCTAssertFalse(tt3!.conflicts(with: sr5!))
//    }
//    
//}
