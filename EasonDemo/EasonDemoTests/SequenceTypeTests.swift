//
//  SequenceTypeTest.swift
//  EasonDemo
//
//  Created by Jie Cao on 12/5/15.
//  Copyright © 2015 Jie Cao. All rights reserved.
//

import XCTest
@testable import EasonDemo

class SequenceTypeTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitWithStringArraySequnce() {
        
        let jsonArray = JSONObject(["This", "is", "a", "string"])
        for jsonObject in jsonArray{
            XCTAssertNotNil(jsonObject)
        }
    }

    func testInitWithObjectsSequnce() {
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
    
}
