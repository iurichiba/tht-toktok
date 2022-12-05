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
    @IBOutlet weak var playerView: LoopingPlayerView!
    
    func setup(withItem item: FeedItem) {
        titleLabel.text = item.title
        usernameLabel.text = "@\(item.user.username)"
        playerView.play(fromURL: item.videoUrl)
    }
    
}
