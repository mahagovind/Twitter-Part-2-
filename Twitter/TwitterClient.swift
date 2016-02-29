//
//  TwitterClient.swift
//  Twitter
//
//  Created by Maha Govindarajan on 2/20/16.
//  Copyright © 2016 Maha Govindarajan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let key = "zBipIEwECFQX39RCgNeCvEdsC"
let secret = "eJc3dnFsU1P4Er2OH1ujaXfPnZP4vw2aAlBZjfbsj3u0Kpn1eD"
let baseUrl = NSURL(string : "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    var login: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: baseUrl, consumerKey: key, consumerSecret: secret)

        }
        return Static.instance
    }
    func login(completion: (user: User?, error: NSError?) -> ()) {
        login = completion
        
        //fetch request token and redirect to auth page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("success")
            let authUrl = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authUrl!)
            }) { (error : NSError!) -> Void in
                print("failure")
                self.login?(user:nil, error: error)

        }
        
    }
    
    func posthomeTweet(params: String, completion: (tweets: [Tweet]?, error : NSError?) -> ()) {
        POST("1.1/statuses/update.json?status=\(params)", parameters: nil, success: { (session:NSURLSessionDataTask!,response:AnyObject?) -> Void in
          //  print("\(response)")
            }, failure: { (session:NSURLSessionDataTask?, error:NSError) -> Void in
        })
        
    }
    
    func getUserProfileDetails(params: String?, completion: (tweets: User?, error : NSError?) -> ()) {
        var url = "1.1//users/show.json?screen_name=\(params)"
        GET("1.1//users/show.json?screen_name=\(params!)", parameters: nil, success: { (session:NSURLSessionDataTask!,response:AnyObject?) -> Void in
         //   print("Profile Values\(response)")
            let user = User(dict: response as! NSDictionary!)
             completion(tweets: user, error : nil)
           
            }, failure: { (session:NSURLSessionDataTask?, error:NSError) -> Void in
             
        })
        
    }
    func homeTimelineWithParams(params: String?, completion: (tweets: [Tweet]?, error : NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (session:NSURLSessionDataTask!,response:AnyObject?) -> Void in
            //  print("\(response)")
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error : nil)
            }, failure: { (session:NSURLSessionDataTask?, error:NSError) -> Void in
                completion(tweets: nil, error : error)
        })
        
    }
    func userFavourites(params: String?, completion: (tweets: [Tweet]?, error : NSError?) -> ()) {
        GET("1.1/favorites/list.json?screen_name=\(params!)", parameters: nil, success: { (session:NSURLSessionDataTask!,response:AnyObject?) -> Void in
            // print("\(response)")
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error : nil)
            }, failure: { (session:NSURLSessionDataTask?, error:NSError) -> Void in
                completion(tweets: nil, error : error)
        })
        
    }
    func userTweets(params: String?, completion: (tweets: [Tweet]?, error : NSError?) -> ()) {
        GET("1.1//statuses/user_timeline.json?screen_name=\(params!)", parameters: nil, success: { (session:NSURLSessionDataTask!,response:AnyObject?) -> Void in
            //  print("\(response)")
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error : nil)
            }, failure: { (session:NSURLSessionDataTask?, error:NSError) -> Void in
                completion(tweets: nil, error : error)
        })
        
    }

    
    func userMedia(params: String?, completion: (tweets: [Tweet]?, error : NSError?) -> ()) {
        GET("1.1//search/tweets.json?q=from%3Agoogle%20since%3A2012-01-31%20filter%3Aimages&include_entities=true", parameters: nil, success: { (session:NSURLSessionDataTask!,response:AnyObject?) -> Void in
           print("\(response)")
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error : nil)
            }, failure: { (session:NSURLSessionDataTask?, error:NSError) -> Void in
                completion(tweets: nil, error : error)
        })
        
    }
    
    func openUrl(url:NSURL)  {
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString:url.query), success: { (accessToken:  BDBOAuth1Credential!) -> Void in
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (session:NSURLSessionDataTask!,response:AnyObject?) -> Void in
                // print("\(response)")
                let user = User(dict: response as! NSDictionary!)
                User.currentUser = user
                self.login?(user:user, error: nil)

                }, failure: { (session:NSURLSessionDataTask?, error:NSError) -> Void in
                    print("error")
                    self.login?(user:nil, error: error)
            })
            }) { (error: NSError!) -> Void in
                print("access error")
                self.login?(user:nil, error: error)

        }

        
        
    }

}
