//
//  ProfileViewCell.swift
//  Twitter
//
//  Created by Maha Govindarajan on 2/28/16.
//  Copyright © 2016 Maha Govindarajan. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell {
    
    @IBOutlet var posterImage: UIImageView!
    
    @IBOutlet var tweetCell: UILabel!
    @IBOutlet var name: UILabel!
    
    @IBOutlet var time: UILabel!
    var tweet :Tweet! {
        didSet {
            tweetCell.text = tweet.text
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


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
