//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Maha Govindarajan on 2/21/16.
//  Copyright © 2016 Maha Govindarajan. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextFieldDelegate {
    var user : User?
    @IBOutlet var name: UILabel!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var message: UITextField!
    @IBOutlet var tweetCounter: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        message.becomeFirstResponder()
        user = User.currentUser
        posterImage.setImageWithURL(NSURL(string: (user?.profileImageURL)!)!)
        name.text = user?.name
        message.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string == " " {
            if message.text != "" {
                var text = Int(tweetCounter.title!)
                text = text!-1
                tweetCounter.title = String(text!)
                
            }
            print("SpaceBar is pressed")
        }
        return true
    }
    
   
    @IBAction func onTweet(sender: AnyObject) {
//        var param1 = NSDictionary()
        var text1 = Int(tweetCounter.title!)
        text1 = text1!-1
        tweetCounter.title = String(text1!)
        let text = message.text
      //  param1.setValue(text, forKey: "status")
        TwitterClient.sharedInstance.posthomeTweet(text!) { (tweets, error) -> () in
            self.dismissViewControllerAnimated(true, completion: nil)
            if error != nil {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            self.dismissViewControllerAnimated(true, completion: nil)

        }
        dismissViewControllerAnimated(true, completion: nil)

    }
  
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
