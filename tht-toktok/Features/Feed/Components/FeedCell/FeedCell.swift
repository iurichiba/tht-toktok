//
//  FeedCell.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 05/12/22.
//

import UIKit

// MARK: - Behavior Configurations
fileprivate struct SwipeActivationConfiguration {
    // trigger/animation thresholds
    let minActivation: CGFloat // min offset to *activate* the trigger and scaling animations
    let animationThreshold: CGFloat // maximum threshold for animation (not the trigger)
    // animation properties
    let bounceDuration: CGFloat // bouncing animation, when the video resets to its original position
}

fileprivate struct FeedCellConfiguration {
    // use this configuration to fine-tune the panGesture trigger
    static let swipeActivation: SwipeActivationConfiguration = .init(
        minActivation: 40, animationThreshold: 200, bounceDuration: 0.5)
}

// MARK: - Convenience Enums
fileprivate enum ReactionAction {
    case Heart
    case Flame
}

fileprivate enum HapticStyle {
    case Selection
    case Success
    case None
}

// MARK: - Class
final class FeedCell: UITableViewCell {
    
    var delegate: FeedCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var playerView: LoopingPlayerView!
    
    @IBOutlet weak var heartActionView: FeedActionView!
    @IBOutlet weak var flameActionView: FeedActionView!
    
    private var panGesture: UIPanGestureRecognizer?
    
    private var cellIndex: Int = -1
    
    // MARK: - Cell Initialization
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.panGestureSetup()
    }
    
    func setup(withItem item: FeedItem, index: Int) {
        cellIndex = index
        titleLabel.text = item.title
        usernameLabel.text = "@\(item.user.username)"
        userAvatar.setImageFromURL(item.user.imageUrl)
        heartActionView.actionCount = item.heartCount
        flameActionView.actionCount = item.flameCount
        playerView.play(fromURL: item.videoUrl, identifier: item.id)
    }
    
    // MARK: - Swipe Gesture
    // MARK: Gesture Setup
    private func panGestureSetup() {
        guard panGesture == nil else { return }
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture?.delegate = self
        self.addGestureRecognizer(panGesture!)
    }
    
    // MARK: Gesture Handling
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let involvesReactionGesture = gestureRecognizer == panGesture || otherGestureRecognizer == panGesture
        if involvesReactionGesture {
            return true
        } else {
            return super.gestureRecognizer(
                gestureRecognizer, shouldRecognizeSimultaneouslyWith: otherGestureRecognizer)
        }
    }
    
    private var panInitialPosition: CGPoint = .zero
    private var actionTriggered: ReactionAction?
    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            panInitialPosition = sender.translation(in: self)
        case .changed:
            // calculate offset
            let newPosition = sender.translation(in: self).x
            let initialPosition = panInitialPosition.x
            let offset = newPosition - initialPosition
            
            // move video
            self.playerView.transform = .init(translationX: offset, y: 0)
            
            // update action, showing action feedback to the user
            let minActivation = FeedCellConfiguration.swipeActivation.minActivation
            let threshold = FeedCellConfiguration.swipeActivation.animationThreshold
            
            switch offset {
            case minActivation...self.frame.width:
                let percentage = (min(threshold, offset) - minActivation)/(threshold - minActivation)
                heartActionView.setDynamicScaling(byPercentage: percentage)
                actionTriggered = .Heart
            case -self.frame.width...(-minActivation):
                let percentage = (-max(-threshold, offset) - minActivation)/(threshold - minActivation)
                flameActionView.setDynamicScaling(byPercentage: percentage)
                actionTriggered = .Flame
            default:
                switch actionTriggered {
                case .Heart: heartActionView.resetDynamicScaling()
                case .Flame: flameActionView.resetDynamicScaling()
                case .none: return
                }; actionTriggered = nil
            }
        case .ended, .cancelled:
            DispatchQueue.main.async { [weak self] in
                self?.panInitialPosition = .zero
                if let action = self?.actionTriggered {
                    self?.triggerAction(action, hapticFeedback: .Success)
                }
                
                UIView.animate(withDuration: FeedCellConfiguration.swipeActivation.bounceDuration,
                               delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0,
                               options: .curveEaseOut) {
                    self?.playerView.transform = .identity
                }
            }
        default: return
        }
    }
    
    // MARK: - Actions
    @IBAction private func heartTapped(_ sender: Any) {
        self.triggerAction(.Heart, hapticFeedback: .Selection)
        
    }
    
    @IBAction private func flameTapped(_ sender: Any) {
        self.triggerAction(.Flame, hapticFeedback: .Selection)
    }
    
    private func triggerAction(_ action: ReactionAction, hapticFeedback: HapticStyle = .None) {
        switch action {
        case .Heart:
            delegate?.heartTapped(forFeedItemAt: cellIndex)
            heartActionView.actionCount += 1
        case .Flame:
            delegate?.flameTapped(forFeedItemAt: cellIndex)
            flameActionView.actionCount += 1
        }
        
        switch hapticFeedback {
        case .Selection:
            UISelectionFeedbackGenerator().selectionChanged()
        case .Success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .None:
            return
        }
    }
    
}

// MARK: - Action Protocols
internal protocol FeedCellDelegate {
    func heartTapped(forFeedItemAt: Int)
    func flameTapped(forFeedItemAt: Int)
}
