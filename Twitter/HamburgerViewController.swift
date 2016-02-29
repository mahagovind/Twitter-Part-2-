//
//  HamburgerViewController.swift
//  Twitter
//
//  Created by Maha Govindarajan on 2/28/16.
//  Copyright © 2016 Maha Govindarajan. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet var Left: NSLayoutConstraint!
    @IBOutlet var contentView: UIView!
    @IBOutlet var menuView: UIView!
    var menuvc : UIViewController! {
        didSet {
            view.layoutIfNeeded()
            menuView.addSubview(menuvc.view)
            
        }
    }
    var mvc : UIViewController! {
        didSet {
            view.layoutIfNeeded()
            contentView.addSubview(mvc.view)
            UIView.animateWithDuration(0.3, animations: { () -> Void in
               
                    self.Left.constant = 0
             
                self.view.layoutIfNeeded()
                
            })

            
        }
    }
    
    var original : CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onPan(sender: UIPanGestureRecognizer) {
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        if sender.state == UIGestureRecognizerState.Began {
            original = Left.constant
            
        } else if sender.state == .Changed {
            Left.constant = original + translation.x
        } else if sender.state == .Ended {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                if velocity.x > 0 {
                    self.Left.constant = 250
                    
                } else {
                    self.Left.constant = 0
                }
                self.view.layoutIfNeeded()

            })
            
        }
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
