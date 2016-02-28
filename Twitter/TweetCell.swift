//
//  TweetCell.swift
//  Twitter
//
//  Created by Maha Govindarajan on 2/21/16.
//  Copyright © 2016 Maha Govindarajan. All rights reserved.
//
@objc protocol TweetCellDelegate {
     func onPosterTapped(tweetCell: TweetCell, screenName : String)
}

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet var tweetText: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var posterImage: UIImageView!
    weak var delegate:TweetCellDelegate?
    var tweet :Tweet! {
        didSet {
           tweetText.text = tweet.text
             let date = NSCalendar.currentCalendar().component(.Day, fromDate: tweet.createdAt!)
             let month = NSCalendar.currentCalendar().component(.Month, fromDate: tweet.createdAt!)
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            
            let months = dateFormatter.shortMonthSymbols
            let monthSymbol = months[month-1] as! String
            
            time.text = monthSymbol + " \(date)"
            name.text = tweet.user?.name
        posterImage.setImageWithURL(NSURL(string:(tweet.user?.profileImageURL)!)!)
            
        }
    }
    func tappedMe()
    {
       print("tapped")
        delegate?.onPosterTapped(self,screenName:(tweet.user?.screenName)!)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target:self, action: Selector("tappedMe"))
        posterImage.addGestureRecognizer(tap)
        posterImage.userInteractionEnabled = true

        // Initialization code
    }
    
   


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
