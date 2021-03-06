//
//  Tweet.swift
//  EasonDemo
//
//  Created by Jie Cao on 12/5/15.
//  Copyright © 2015 Jie Cao. All rights reserved.
//

import UIKit

class Tweet: NSObject, JSONSerialization {
    var id:Int?
    var createdAt:NSDate?
    var user:TweetUser?
    var text:String?
    
    required init?(jsonObject: JSONObject) {
        self.id =? jsonObject["id"]
        self.text =? jsonObject["text"]
        self.createdAt = JSONObject.dateTransformer(jsonObject["created_at"], dateFormatter: "EEE MMM dd HH:mm:ss Z yyyy")
        
        self.user =? jsonObject["user"]
    }
}
