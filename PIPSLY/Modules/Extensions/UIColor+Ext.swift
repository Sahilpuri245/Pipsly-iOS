//
//  UIColor+Ext.swift
//  ROUTE
//
//  Created by Sumit Tripathi on 18/07/17.
//  Copyright © 2017 KiwiTech. All rights reserved.
//

import UIKit

extension UIColor {
    class func colorWithHexString(_ hexStr: String, alpha: CGFloat) -> UIColor {
        var hexStr = hexStr, alpha = alpha
        hexStr = hexStr.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        } else {
            print("invalid hex string")
            return UIColor.white
        }
    }
    class func colorWithRGBA(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: redValue/255.0, green: greenValue/255.0, blue: blueValue/255.0, alpha: alpha)
    }
}
