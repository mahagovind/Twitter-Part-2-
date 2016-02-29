//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Maha Govindarajan on 2/28/16.
//  Copyright © 2016 Maha Govindarajan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var followers: UILabel!
    @IBOutlet var following: UILabel!
    @IBOutlet var desc: UILabel!
    @IBOutlet var screenName: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var poster: UIImageView!
    @IBOutlet var banner: UIImageView!
    @IBOutlet var tableView: UITableView!
    var tweets : [Tweet]?
    var user = User.currentUser
    override func viewDidLoad() {
        super.viewDidLoad()
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        if tweets == nil {
            setTweets()
        }
        followers.text = "\(user!.followersCount!)"
        following.text = "\(user!.followingCount!)"
        desc.text = user!.desc!
        screenName.text = "@" + user!.screenName!
        name.text = user!.name
        banner.setImageWithURL(NSURL(string: user!.bannerImageURL!)!)

        poster.setImageWithURL(NSURL(string: user!.profileImageURL!)!)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressed:")
        self.tabBarController?.view.addGestureRecognizer(longPressRecognizer)
        segmentedControl.selectedSegmentIndex = 0
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func loadList(notification: NSNotification){
        //load data here
        viewDidLoad()
        self.tableView.reloadData()
    }
    
    func setTweets()
    {
        TwitterClient.sharedInstance.userTweets(user?.screenName!) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }

    }
    
    func longPressed(sender: UILongPressGestureRecognizer)
    {
        print("longpressed")
      //  self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext;

        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("AccountViewController") as! AccountViewController
        vc.view.backgroundColor = UIColor.clearColor()
        vc.view.opaque = false
        vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext;
        self.presentViewController(vc, animated: true, completion: nil)
            
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets == nil {
            return 0
        } else {
        
        return (tweets?.count)!
        }
    }
    
   
    @IBAction func onChanged(sender: AnyObject) {
        var control = sender as! UISegmentedControl
        if(control.selectedSegmentIndex == 0) {
            
            TwitterClient.sharedInstance.userTweets(user?.screenName!) { (tweets, error) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            }
        }
        else {
            TwitterClient.sharedInstance.userFavourites(user?.screenName!) { (tweets, error) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileViewCell", forIndexPath: indexPath) as! ProfileViewCell
        cell.tweet = tweets![indexPath.row]
        return cell
        
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
