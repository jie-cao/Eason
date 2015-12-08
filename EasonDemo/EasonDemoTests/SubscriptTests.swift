//
//  SubscriptTestCase.swift
//  EasonDemo
//
//  Created by Jie Cao on 12/5/15.
//  Copyright © 2015 Jie Cao. All rights reserved.
//

import XCTest
@testable import EasonDemo

class SubscriptTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSubscriptWithStringAndNumberArrayIndexOutOfBound() {
        let jsonArray:JSONObject = ["This", "is", "a", "string", 1, 2, 3, 4]
        XCTAssertNil(jsonArray[999].int)
        XCTAssertNil(jsonArray[999].string)
        XCTAssertNil(jsonArray[999].bool)
    }
    
    func testSubscriptWithStringAndNumberArray() {
        let jsonArray:JSONObject = ["This", "is", "a", "string", 1, 2, 3, 4]
        XCTAssertEqual("This", jsonArray[0].string)
        XCTAssertEqual("is", jsonArray[1].string)
        XCTAssertEqual("a", jsonArray[2].string)
        XCTAssertEqual("string", jsonArray[3].string)
        XCTAssertEqual(1, jsonArray[4].intValue)
        XCTAssertEqual(2, jsonArray[5].intValue)
        XCTAssertEqual(3, jsonArray[6].intValue)
    }
    
    func testSubscriptWithDictionary() {
        let jsonObject:JSONObject = ["name": "hello", "id":123]
        XCTAssertEqual("hello", jsonObject["name"].stringValue)
        XCTAssertEqual(123, jsonObject["id"].intValue)
    }
    
    func testSubscriptWithDictionaryKeyNotExist() {
        let jsonObject:JSONObject = ["name": "hello", "id":123]
        XCTAssertNil(jsonObject["abc"].int)
        XCTAssertNil(jsonObject["bcd"].string)
    }
    
}
