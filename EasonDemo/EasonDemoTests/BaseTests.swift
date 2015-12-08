//
//  EasonDemoTests.swift
//  EasonDemoTests
//
//  Created by Jie Cao on 12/5/15.
//  Copyright © 2015 Jie Cao. All rights reserved.
//

import XCTest
@testable import EasonDemo

class BaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitWithNil() {
        let jsonObject = JSONObject(nil)
        XCTAssertNil(jsonObject.string)
        XCTAssertNil(jsonObject["abc"].string)
    }
    
    func testInitWithObject() {
        let object: AnyObject = ["name": "Hello", "id": 123]
        let jsonObject = JSONObject(object)
        XCTAssertEqual("Hello", jsonObject["name"].stringValue)
        XCTAssertEqual(123, jsonObject["id"].intValue)
    }
    
    func testInitWithData() {
        if let path = NSBundle(forClass: BaseTests.self).pathForResource("twitter", ofType: "json") {
            let data: NSData?
            do {
                data = try NSData(contentsOfFile: path, options: [])
            } catch _ {
                data = nil
            }
            
            let jsonArray = JSONObject(data:data)
            for jsonObject in jsonArray{
                XCTAssertNotNil(jsonObject["id"].int)
                XCTAssertNotNil(jsonObject["text"].string)
            }
        }
    }
    
    func testInitWithString() {
        let jsonString = "{\"name\": \"hello\", \"id\":123}"
        let jsonObject = JSONObject(string: jsonString)
        XCTAssertEqual("hello", jsonObject["name"].stringValue)
        XCTAssertEqual(123, jsonObject["id"].intValue)
    }
    
}
