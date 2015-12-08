//
//  CustomObjectTransformTest.swift
//  EasonDemo
//
//  Created by Jie Cao on 12/5/15.
//  Copyright © 2015 Jie Cao. All rights reserved.
//

import XCTest
@testable import EasonDemo

class CustomObjectTransformTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCustomObjectTransform() {
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
                XCTAssertEqual(240558470661799936, tweetsArray[0].id)
                XCTAssertEqual("just another test", tweetsArray[0].text)
                XCTAssertEqual(119476949, tweetsArray[0].user?.id)
                XCTAssertEqual("OAuth Dancer", tweetsArray[0].user?.name)
                XCTAssertEqual(NSURL(string: "http://a0.twimg.com/profile_images/730275945/oauth-dancer_normal.jpg"), tweetsArray[0].user?.profile_image_url)
            }
        } else {
            XCTFail("Failed to convert array with custome objects")
        }
    }
    
}
