//
//  DetailsViewController.swift
//  Twitter
//
//  Created by Maha Govindarajan on 2/21/16.
//  Copyright © 2016 Maha Govindarajan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var time: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var posterImage: UIImageView!
    
    @IBOutlet var favImage: UIImageView!
    @IBOutlet var retweetImage: UIImageView!
    @IBOutlet var favCount: UILabel!
    @IBOutlet var retweetCount: UILabel!
    @IBOutlet var tweetText: UILabel!
    var ret = 0
    var fav = 0
     var tweet :Tweet!
      override func viewDidLoad() {
        super.viewDidLoad()
       
                tweetText.text = tweet.text
                time.text = String(tweet.createdAt!)
                name.text = tweet.user?.name
                posterImage.setImageWithURL(NSURL(string:(tweet.user?.profileImageURL)!)!)
                retweetCount.text = String(tweet.tweetCount!)
                favCount.text = String(tweet.favCount!)
        var tap = UITapGestureRecognizer(target: self, action: Selector("tappedMe"))
        retweetImage.addGestureRecognizer(tap)
        retweetImage.userInteractionEnabled = true
        
        var tap2 = UITapGestureRecognizer(target: self, action: Selector("tappedMe2"))
        favImage.addGestureRecognizer(tap2)
        favImage.userInteractionEnabled = true

          


        // Do any additional setup after loading the view.
    }
    func tappedMe()
    {
        var text = Int(retweetCount.text!)
        if ret % 2 == 0 {
        text = text! + 1
            retweetImage.image = retweetImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            retweetImage.tintColor = UIColor.redColor()
        } else {
            retweetImage.image = retweetImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            retweetImage.tintColor = UIColor.lightGrayColor()
            text = text! - 1
 
        }
        ret = ret + 1
        retweetCount.text = String(text!)
    }
    
    func tappedMe2()
    {
        var text = Int(favCount.text!)

        if fav % 2 == 0 {
        text = text! + 1
            favImage.image = favImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            favImage.tintColor = UIColor.redColor()
        } else {
            favImage.image = favImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            favImage.tintColor = UIColor.lightGrayColor()

            text = text! - 1

        }
        fav++
        favCount.text = String(text!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
