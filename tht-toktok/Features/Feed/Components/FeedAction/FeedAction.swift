//
//  FeedAction.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 05/12/22.
//

import UIKit

final class FeedActionView: UIControl {
    
    @IBOutlet weak var zeroCountImage: UIImageView!
    @IBOutlet weak var multiCountImage: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
    var actionCount = 0 {
        didSet {
            setCount(actionCount)
        }
    }
 
    // MARK: - Initialization
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.actionCount = 0
        self.touchSetup()
    }
    
    // MARK: - Touch Recognition
    private func touchSetup() {
        self.addTarget(self, action: #selector(onTouch), for: .touchUpInside)
    }
    
    @objc private func onTouch() {
        self.actionCount += 1
    }
    
    // MARK: - Component Animation
    private func setCount(_ newCount: Int, animated: Bool = true) {
        countLabel.text = String(newCount)
        
        let positiveCount = newCount > 0
        let runAnimations = {
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
                self.zeroCountImage.alpha = positiveCount ? 0 : 1
                self.multiCountImage.alpha = positiveCount ? 1 : 0
                self.multiCountImage.transform = positiveCount ? .init(scaleX: 0.5, y: 0.5) : .identity
                self.countLabel.transform = positiveCount ? .init(scaleX: 0.75, y: 0.75) : .identity
            } completion: { completed in
                guard completed else { return }
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                    self.multiCountImage.transform = .identity
                    self.countLabel.transform = .identity
                }
            }
        }
        
        if animated {
            runAnimations()
        } else {
            UIView.performWithoutAnimation {
                runAnimations()
            }
        }
    }
    
}
