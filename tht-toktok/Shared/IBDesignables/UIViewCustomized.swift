//
//  UIViewCustomized.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 05/12/22.
//

import UIKit

@IBDesignable
class UIViewCustomized: UIView {
    
    @IBInspectable var topGradient: UIColor = .clear
    @IBInspectable var bottomGradient: UIColor = .clear
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [topGradient.cgColor, bottomGradient.cgColor]
    }
    
}
