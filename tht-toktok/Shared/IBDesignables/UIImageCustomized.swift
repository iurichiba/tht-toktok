//
//  UIImageCustomized.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 05/12/22.
//

import UIKit

@IBDesignable
class UIImageCustomized: UIImageView {
    
    // MARK: - Border Properties
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)}
        set { layer.borderColor = newValue.cgColor }
    }
    
    // MARK: - Shadow Properties
    @IBInspectable
    var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    @IBInspectable
    var shadowOffset : CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    @IBInspectable
    var shadowColor : UIColor {
        get { return UIColor(cgColor: layer.shadowColor ?? UIColor.clear.cgColor) }
        set { layer.shadowColor = newValue.cgColor }
    }
    
    @IBInspectable
    var shadowOpacity : Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    
}
