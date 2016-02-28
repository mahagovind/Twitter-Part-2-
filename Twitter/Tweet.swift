//
//  Tweet.swift
//  Twitter
//
//  Created by Maha Govindarajan on 2/20/16.
//  Copyright © 2016 Maha Govindarajan. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text :String?
    var createdAtString : String?
    var createdAt : NSDate?
    var tweetCount: Int?
    var favCount: Int?
    var id : Int?

    init(dict :NSDictionary) {
        user = User(dict: (dict["user"] as? NSDictionary)!)
        text = dict["text"] as? String
        createdAtString = dict["created_at"] as? String
        tweetCount = dict["retweet_count"] as? Int
        favCount = dict["favorite_count"] as? Int
        id = dict["id"] as? Int
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "US_en")
        formatter.timeZone = NSTimeZone(name: "GMT")
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
    }
    class func tweetsWithArray(array:[NSDictionary]) ->[Tweet] {
        var tweets = [Tweet]()
        for dict in array {
            tweets.append(Tweet(dict: dict))
        }
        return tweets
    
    }
    
   
}
