//
//  TweetUser.swift
//  EasonDemo
//
//  Created by Jie Cao on 12/5/15.
//  Copyright © 2015 Jie Cao. All rights reserved.
//

import UIKit

class TweetUser: NSObject, JSONSerialization {
    var id:Int?
    var name:String?
    var profile_image_url:NSURL?
    
    required init?(jsonObject: JSONObject) {
        self.name =? jsonObject["name"]
        self.id =? jsonObject["id"]
        self.profile_image_url = jsonObject["profile_image_url"].URL
    }
}
