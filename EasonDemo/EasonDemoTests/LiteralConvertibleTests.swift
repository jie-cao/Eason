//
//  LiteralConvertibleTest.swift
//  EasonDemo
//
//  Created by Jie Cao on 12/5/15.
//  Copyright © 2015 Jie Cao. All rights reserved.
//

import XCTest
@testable import EasonDemo

class LiteralConvertibleTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLiteralConverticableWithNumber() {
        let jsonObject:JSONObject = 12345.67890
        XCTAssertEqual(jsonObject.int!, 12345)
        XCTAssertEqual(jsonObject.intValue, 12345)
        XCTAssertEqual(jsonObject.double!, 12345.67890)
        XCTAssertEqual(jsonObject.doubleValue, 12345.67890)
        XCTAssertTrue(jsonObject.float! == 12345.67890)
        XCTAssertTrue(jsonObject.floatValue == 12345.67890)
    }
    
    func testLiteralConverticableWithBool() {
        var jsonObject:JSONObject = true
        XCTAssertEqual(jsonObject.bool!, true)
        XCTAssertEqual(jsonObject.boolValue, true)
        jsonObject = false
        XCTAssertEqual(jsonObject.bool!, false)
        XCTAssertEqual(jsonObject.boolValue, false)
    }
    
    func testLiteralConverticableWithString() {
        let jsonObject:JSONObject = "Hello World"
        XCTAssertEqual("Hello World", jsonObject.stringValue)
    }
    
    func testLiteralConverticableWithArray() {
        let jsonArray:JSONObject = ["This", "is", "a", "string", 1, 2, 3, 4]
        XCTAssertEqual(8, jsonArray.arrayValue.count)
        XCTAssertEqual(NSArray(array: ["This", "is", "a", "string", 1, 2, 3, 4]), NSArray(array: jsonArray.arrayValue))
    }
    
    func testLiteralConverticableWithDictionary() {
        let jsonObject:JSONObject = ["name": "hello", "id":123]
        XCTAssertEqual("hello", jsonObject["name"].stringValue)
        XCTAssertEqual(123, jsonObject["id"].intValue)
    }
    
}
