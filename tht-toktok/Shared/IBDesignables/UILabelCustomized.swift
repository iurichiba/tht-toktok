//
//  UILabelCustomized.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 05/12/22.
//

import UIKit

@IBDesignable
class UILabelCustomized: UILabel {
    
    @IBInspectable
        var shadowRadius: CGFloat {
            get { return layer.shadowRadius }
            set { layer.shadowRadius = newValue }
        }
    
        @IBInspectable
        override var shadowOffset : CGSize {
            get { return layer.shadowOffset }
            set { layer.shadowOffset = newValue }
        }

        @IBInspectable
        override var shadowColor : UIColor? {
            get { return UIColor.init(cgColor: layer.shadowColor!) }
            set { layer.shadowColor = newValue?.cgColor }
        }
    
        @IBInspectable
        var shadowOpacity : Float {
            get { return layer.shadowOpacity }
            set { layer.shadowOpacity = newValue }
        }
    
}

