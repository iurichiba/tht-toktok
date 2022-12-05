//
//  FeedCell.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 05/12/22.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    func setup(withItem item: FeedItem) {
        print("On screen:", item.title)
        titleLabel.text = item.title
        usernameLabel.text = "@\(item.user.username)"
    }
    
}
