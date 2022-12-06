//
//  FeedCell.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 05/12/22.
//

import UIKit

final class FeedCell: UITableViewCell {
    
    var delegate: FeedCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var playerView: LoopingPlayerView!
    
    @IBOutlet weak var heartActionView: FeedActionView!
    @IBOutlet weak var flameActionView: FeedActionView!
    
    fileprivate var cellIndex: Int = -1
    
    // MARK: - Initialization
    func setup(withItem item: FeedItem, index: Int) {
        cellIndex = index
        titleLabel.text = item.title
        usernameLabel.text = "@\(item.user.username)"
        userAvatar.setImageFromURL(item.user.imageUrl)
        heartActionView.actionCount = item.heartCount
        flameActionView.actionCount = item.flameCount
        playerView.play(fromURL: item.videoUrl, identifier: item.id)
    }
    
    // MARK: - Actions
    @IBAction private func flameTapped(_ sender: Any) {
        delegate?.flameTapped(forFeedItemAt: cellIndex)
    }
    
    @IBAction private func heartTapped(_ sender: Any) {
        delegate?.heartTapped(forFeedItemAt: cellIndex)
    }
    
}

internal protocol FeedCellDelegate {
    func heartTapped(forFeedItemAt: Int)
    func flameTapped(forFeedItemAt: Int)
}
