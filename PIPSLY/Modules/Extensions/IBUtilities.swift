//
//  IBUtilities.swift
//  PIPSLY

//
//  Created by KiwiTech on 12/04/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }

}

@IBDesignable extension UILabel {

    @IBInspectable var adaptiveFont: Bool {
        set {
            if newValue == true {
                let fontDescriptor = self.font.fontDescriptor
                let currentFontSize = fontDescriptor.pointSize
                let newFontSize = (currentFontSize/320)*UIScreen.main.bounds.size.width
                let newFont = UIFont(descriptor: fontDescriptor, size: newFontSize)
                font = nil
                font = newFont
            }
        }
        get {
            return false
        }
    }
}

@IBDesignable extension UIButton {
    @IBInspectable var adaptiveFont: Bool {
        set {
            if newValue == true {
                let fontDescriptor = self.titleLabel!.font.fontDescriptor
                let currentFontSize = fontDescriptor.pointSize
                let newFontSize = (currentFontSize/320)*UIScreen.main.bounds.size.width
                let newFont = UIFont(descriptor: fontDescriptor, size: newFontSize)
                titleLabel!.font = nil
                titleLabel!.font = newFont
            }
        }
        get {
            return false
        }
    }
}

@IBDesignable extension UITextField {
    @IBInspectable var padding: CGFloat {
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: self.frame.size.height))
            leftView = paddingView
            leftViewMode = UITextFieldViewMode.always
        }
        get {
            return 0

        }
    }
}
