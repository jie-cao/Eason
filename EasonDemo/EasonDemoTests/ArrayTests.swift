//
//  ArrayTests.swift
//  EasonDemo
//
//  Created by Jie Cao on 12/5/15.
//  Copyright © 2015 Jie Cao. All rights reserved.
//

import XCTest
@testable import EasonDemo

class ArrayTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStringAndNumberArray() {
        let jsonArray:JSONObject = ["This", "is", "a", "string", 1, 2, 3, 4]
        XCTAssertEqual("This", jsonArray[0].string)
        XCTAssertEqual("is", jsonArray[1].string)
        XCTAssertEqual("a", jsonArray[2].string)
        XCTAssertEqual("string", jsonArray[3].string)
        XCTAssertEqual(1, jsonArray[4].intValue)
        XCTAssertEqual(2, jsonArray[5].intValue)
        XCTAssertEqual(3, jsonArray[6].intValue)
    }
    
    func testArrayWithObjectMapping() {
        if let path = NSBundle(forClass: ArrayTests.self).pathForResource("twitter", ofType: "json") {
            let data: NSData?
            do {
                data = try NSData(contentsOfFile: path, options: [])
            } catch _ {
                data = nil
            }
            let jsonObject = JSONObject(data:data)
            
            let tweets:[Tweet]? = JSONObject.arrayTransformer(jsonObject)
            if let tweetsArray = tweets{
                for tweet in tweetsArray{
                    XCTAssertNotNil(tweet.id)
                    XCTAssertNotNil(tweet.createdAt)
                    XCTAssertNotNil(tweet.user?.id)
                    XCTAssertNotNil(tweet.user?.name)
                    XCTAssertNotNil(tweet.user?.profile_image_url)
                }
            }
        } else {
            XCTFail("Failed to convert array with custome objects")
        }
    }
    
}
