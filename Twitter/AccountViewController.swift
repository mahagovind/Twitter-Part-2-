//
//  AccountViewController.swift
//  Twitter
//
//  Created by Maha Govindarajan on 2/28/16.
//  Copyright © 2016 Maha Govindarajan. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, AccountCellDelegate {
    var deleted : Bool = false
    var titles = ["Account","More Options"]
    var names = ["Maha Govindarajan", "Codepath Test"]
    var screennames = ["mahigovind","mahacodepath"]
    var urls = ["http://pbs.twimg.com/profile_images/703835338158972928/8CwbAM6x_normal.jpg",
    "http://pbs.twimg.com/profile_images/703834439059570689/V-FanVxf_normal.jpg"]
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let tap = UITapGestureRecognizer(target:self, action: Selector("tappedMe"))
        self.view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    func tappedMe () {
        self.dismissViewControllerAnimated(true, completion: nil)
 
    }
    
    func valuechanged(cell: AccountCell, screen: String) {
        TwitterClient.sharedInstance.getUserProfileDetails(
            
            
            screen) { (tweets, error) -> () in
                
                TwitterClient.sharedInstance.userTweets(screen) { (tweetsUpdated, error) -> () in
                    
                    
                    let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
                    vc.user = tweets!
                    vc.tweets = tweetsUpdated
                    vc.reloadInputViews()
                    NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
                    self.navigationController?.pushViewController(vc, animated: false)
                    self.dismissViewControllerAnimated(true, completion: nil)

                                }
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            names.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            deleted = true
            tableView.reloadData()
        }
    }
    

     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AccountCell", forIndexPath: indexPath) as! AccountCell
        cell.delegate = self
        cell.screenName.text = screennames[indexPath.row]
        cell.name.text = names[indexPath.row]
        cell.poster.setImageWithURL(NSURL(string: urls[indexPath.row])!)
        
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView,
        titleForHeaderInSection section: Int) -> String? {
            return titles[section]
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return names.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
