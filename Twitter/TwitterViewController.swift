//
//  ViewController.swift
//  Twitter
//
//  Created by Maha Govindarajan on 2/20/16.
//  Copyright © 2016 Maha Govindarajan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.login(){
            (User : User?, error: NSError?) in
            if error == nil {
                self.performSegueWithIdentifier("loginSegue", sender: self)
                
            } else {
                
            }
        }
    
      }
}

