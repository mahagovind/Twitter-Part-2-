//
//  AccountCell.swift
//  Twitter
//
//  Created by Maha Govindarajan on 2/28/16.
//  Copyright © 2016 Maha Govindarajan. All rights reserved.
//

import UIKit
protocol AccountCellDelegate {
    func valuechanged(cell : AccountCell , screen : String)
}

class AccountCell: UITableViewCell {

    @IBOutlet var check: UIImageView!
    @IBOutlet var screenName: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var poster: UIImageView!
    var delegate: AccountCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        check.hidden = true
        let tap = UITapGestureRecognizer(target:self, action: Selector("tappedMe"))
        self.addGestureRecognizer(tap)

        // Initialization code
    }
    func tappedMe () {
        check.hidden = false
        delegate!.valuechanged(self, screen: screenName.text!)
       print("Cell tapped")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
