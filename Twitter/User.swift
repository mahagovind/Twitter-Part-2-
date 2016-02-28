//
//  User.swift
//  Twitter
//
//  Created by Maha Govindarajan on 2/20/16.
//  Copyright © 2016 Maha Govindarajan. All rights reserved.
//

import UIKit

var _currentUser : User?
let userloginNotification = "userloginNotification"
let userlogoutNotification = "userlogoutNotification"

class User: NSObject {
    var name : String?
    var screenName :String?
    var profileImageURL: String?
    var bannerImageURL: String?
    var desc : String?
    var followersCount : Int?
    var followingCount : Int?

    var tagline: String?
    var dict :NSDictionary
    
    init(dict :NSDictionary) {
        self.dict = dict
        name = dict["name"] as? String
        screenName = dict["screen_name"] as? String
        profileImageURL = dict["profile_image_url"] as? String
        tagline = dict["description"] as? String
        bannerImageURL = dict["profile_banner_url"] as? String
        desc = dict["description"] as? String
        followersCount = dict["followers_count"] as? Int
        followingCount = dict["friends_count"] as? Int
        
    }
    
    func logout () {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userlogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
        let data = NSUserDefaults.standardUserDefaults().objectForKey("currentUser") as? NSData
                if(data != nil) {
        var dictionary :NSDictionary?
        do {
        dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue:0)) as! NSDictionary
        _currentUser = User(dict: dictionary!)
    } catch let error as NSError {
        print("error : \(error)")
        }
        
        }
        
        }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            if _currentUser != nil
            {
                var data :NSData?
                do {
                data = try NSJSONSerialization.dataWithJSONObject(user!.dict, options: NSJSONWritingOptions(rawValue:0))
                    } catch let error as NSError {
                      print("error : \(error)")
                    }
                if( data != nil) {
                 NSUserDefaults.standardUserDefaults().setObject(data, forKey: "currentUser")
                 NSUserDefaults.standardUserDefaults().synchronize()
                      
                }
            }
             else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "currentUser")
                NSUserDefaults.standardUserDefaults().synchronize()

            }
        }
        
    }

}
