//
//  MenuViewController.swift
//  Twitter
//
//  Created by Maha Govindarajan on 2/28/16.
//  Copyright © 2016 Maha Govindarajan. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    @IBOutlet var tableView: UITableView!
    
    var tvs : [UIViewController] = []
    var tvc :UIViewController!
     var mvc :UIViewController!
     var pvc :UIViewController!
    var hvc: HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       tvc = self.storyboard?.instantiateViewControllerWithIdentifier("tweetsVC") as! TweetsViewController
        pvc = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        mvc = self.storyboard?.instantiateViewControllerWithIdentifier("tweetsVC") as! TweetsViewController
        
        hvc = self.storyboard?.instantiateViewControllerWithIdentifier("HamburgerViewController") as! HamburgerViewController

        tvs.append(tvc)
        tvs.append(mvc)
        tvs.append(pvc)
        hvc.mvc = self.storyboard?.instantiateViewControllerWithIdentifier("myTabController") as! UITabBarController
        tableView.delegate = self
        tableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
     
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
       hvc.mvc = tvs[indexPath.row]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("HC", forIndexPath: indexPath)
    let values = ["Timeline", "Profile", "Mention"]
    cell.textLabel?.text = values[indexPath.row]
    return cell
        
    }
    

  

}
