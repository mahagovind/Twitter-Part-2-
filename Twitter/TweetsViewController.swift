//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Maha Govindarajan on 2/21/16.
//  Copyright © 2016 Maha Govindarajan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,TweetCellDelegate {
    var tweets : [Tweet]?
    var selectedTweet : Tweet?
    
    @IBOutlet var tableView: UITableView!
    var isMoreDataLoading = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
                let refreshControl = UIRefreshControl()
          refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120 //for scroll height
        tableView.insertSubview(refreshControl, atIndex: 0)

        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
 
    }
    func onPosterTapped(tweetCell: TweetCell, screenName : String) {
       
        TwitterClient.sharedInstance.getUserProfileDetails(
            
            
            screenName) { (tweets, error) -> () in
                
                TwitterClient.sharedInstance.userTweets(screenName) { (tweetsUpdated, error) -> () in


            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
                vc.user = tweets!
                    vc.tweets = tweetsUpdated
            self.navigationController?.pushViewController(vc, animated: true)
        }
        }
     
    }
       
    func loadMoreData() {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.isMoreDataLoading = false
            self.tableView.reloadData()
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                
                isMoreDataLoading = true
                
                // Code to load more results
                loadMoreData()
            }
        }
    }
    
//    override func viewWillAppear(animated: Bool) {
//        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
//            self.tweets = tweets
//            self.tableView.reloadData()
//        }
//
//        
//    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }

        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tweets == nil) {
            return 0
        } else {
        return tweets!.count
        }
    }
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//         selectedTweet = tweets![indexPath.row]
//        tableView.deselectRowAtIndexPath(indexPath, animated: false)
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
       cell.delegate = self
        cell.tweet = tweets![indexPath.row]
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func onLogoutClicked(sender: AnyObject) {
         User.currentUser?.logout()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "detailsSegue") {
            let indexPath = tableView.indexPathForCell(sender as! TweetCell)
           print(" index path : \(indexPath!.row)")
            let vc = segue.destinationViewController as! DetailsViewController
            vc.tweet = tweets![(indexPath?.row)!]
        } 
        
    }
}
