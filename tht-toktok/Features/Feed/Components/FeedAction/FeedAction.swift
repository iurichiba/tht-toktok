//
//  FeedAction.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 05/12/22.
//

import UIKit

// MARK: - Behavior Configurations
fileprivate struct DynamicScalingConfiguration {
    // increases above scale 1; so if you set 0.5, it'll max out at 1.5x the size
    let maxScaleIncrease: CGFloat
}

fileprivate struct FeedActionViewConfiguration {
    static let dynamicScaling = DynamicScalingConfiguration(
        maxScaleIncrease: 0.5)
}

// MARK: - Class
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
    
    // MARK: - Dynamic Scaling (visual feedback only)
    func setDynamicScaling(byPercentage percentage: CGFloat) {
        self.zeroCountImage.alpha = 0
        self.multiCountImage.alpha = 1
        let maxScaleIncrease = FeedActionViewConfiguration.dynamicScaling.maxScaleIncrease
        let scale = 1 + (maxScaleIncrease * percentage)
        self.multiCountImage.transform = .init(scaleX: scale, y: scale)
    }
    
    func resetDynamicScaling(animated: Bool = true) {
        let runAnimations = {
            UIView.animate(withDuration: 0.25) {
                let hasPositiveValue = self.actionCount > 0
                self.zeroCountImage.alpha = hasPositiveValue ? 0 : 1
                self.multiCountImage.alpha = hasPositiveValue ? 1 : 0
            }
        }
        
        if (animated) {
            runAnimations()
        } else {
            UIView.performWithoutAnimation {
                runAnimations()
            }
        }
        
    }
    
}
