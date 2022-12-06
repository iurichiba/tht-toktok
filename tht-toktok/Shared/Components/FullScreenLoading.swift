//
//  FullScreenLoading.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 06/12/22.
//

import UIKit

final class FullScreenLoading: UIView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.tintColor = .white
        return indicator
    }()
    
    var loading = true {
        didSet {
            if !loading {
                self.openCurtains()
            }
        }
    }
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.viewSetup()
    }
    
    // MARK: - View Setup
    private func viewSetup() {
        self.backgroundColor = .black
        activityIndicator.frame = self.frame
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
    }
    
    // MARK: - Animation
    private func openCurtains(animated: Bool = true) {
        let runAnimations = {
            UIView.animate(withDuration: 0.75) {
                self.activityIndicator.alpha = 0
                self.activityIndicator.transform = .init(scaleX: 0.1, y: 0.1)
            }

            UIView.animate(withDuration: 1.75) {
                self.alpha = 0
            } completion: { _ in
                self.removeFromSuperview()
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
