//
//  UILabel+Ext.swift
//  PIPSLY
//
//  Created by KiwiTech on 07/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation
import UIKit
// attribute String
extension UILabel {
    func attributeTextColorChange (fullText : String , changeText : String ,fontNameText:String,fontSizeText:CGFloat) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(.font, value: UIFont(name: fontNameText, size: fontSizeText)!, range: range)
        
        self.attributedText = attribute
    }
    
    func addImageWith(name: String, behindText: Bool) {
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: name)
        let attachmentString = NSAttributedString(attachment: attachment)
        
        guard let txt = self.text else {
            return
        }
        
        if behindText {
            let strLabelText = NSMutableAttributedString(string: txt)
            strLabelText.append(attachmentString)
            self.attributedText = strLabelText
        } else {
            let strLabelText = NSAttributedString(string: txt)
            let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            self.attributedText = mutableAttachmentString
        }
    }
    
    func removeImage() {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
}

@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 0
    @IBInspectable var bottomInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
