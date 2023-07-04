//
//  UITextField+Ext.swift
//  PIPSLY
//
//  Created by Sumit Tripathi on 18/07/17.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

func getScreenScaleFactor() -> CGFloat {
    if UIScreen.main.isPortrait() {
        return UIScreen.main.bounds.size.width / 320.0
    } else {
        return UIScreen.main.bounds.size.height / 320.0
    }
}

extension UITextField {

    override open func awakeFromNib() {
        super.awakeFromNib()
    }
    var readonly: Bool {
        get {
            return self.getAdditions().readonly
        } set {
            self.getAdditions().readonly = newValue
        }
    }

    private func getAdditions() -> UITextFieldAdditions {
        var additions = objc_getAssociatedObject(self, &key) as? UITextFieldAdditions
        if additions == nil {
            additions = UITextFieldAdditions()
            objc_setAssociatedObject(self, &key, additions!, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        return additions!
    }

    open override func target(forAction action: Selector, withSender sender: Any?) -> Any? {
        if ((action == #selector(UIResponderStandardEditActions.paste(_:)) || (action == #selector(UIResponderStandardEditActions.cut(_:)))) && self.readonly) {
            return nil
        }
        return super.target(forAction: action, withSender: sender)
    }

    func setCursor(position: UITextRange) {
        selectedTextRange = position
    }

    @IBInspectable var placeholderColor: UIColor {
        get {
            guard let currentAttributedPlaceholderColor = attributedPlaceholder?.attribute(NSAttributedStringKey.foregroundColor, at: 0, effectiveRange: nil) as? UIColor else { return .red }
            return currentAttributedPlaceholderColor
        }
        set {
            guard let currentAttributedString = attributedPlaceholder else { return }
            let attributes = [NSAttributedStringKey.foregroundColor: newValue]

            attributedPlaceholder = NSAttributedString(string: currentAttributedString.string, attributes: attributes)
        }
    }
}
//// to add color and BorderWidth

public extension UITextField{
    
    func addTextFieldBorderColorWidth(borderColor:UIColor,borderWidth:CGFloat){
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
}
