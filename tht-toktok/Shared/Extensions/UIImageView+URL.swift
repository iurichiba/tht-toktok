//
//  UIImageView+URL.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 05/12/22.
//

import UIKit

extension UIImageView {
    
    func setImageFromURL(_ url: URL, hideWhileLoading: Bool = true) {
        if (hideWhileLoading) {
            self.setVisibility(visible: false, animated: false)
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        if (hideWhileLoading) {
                            self?.setVisibility(visible: true)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Hide/Show Animation (optional)
    private func setVisibility(visible: Bool, animated: Bool = true) {
        let transform = { [weak self] in
            UIView.animate(withDuration: 0.25) {
                self?.alpha = visible ? 1 : 0
                self?.transform = visible ? .identity : .init(rotationAngle: 90).scaledBy(x: 0.1, y: 0.1)
            }
        }
        
        if (animated) {
            transform()
        } else {
            UIView.performWithoutAnimation {
                transform()
            }
        }
    }
    
}
