//
//  UIImageView+Ext.swift
//  PIPSLY
//
//  Created by KiwiTech on 1/24/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    func setImageWithUrl(urlstring: String, placeholderImage: UIImage) {
        guard let url = URL(string: urlstring) else {
            self.image = placeholderImage
            return
        }
        self.sd_setImage(with: url, placeholderImage: placeholderImage, options: .highPriority)
    }

    func setImageWithUrl(urlstring: String, placeholderImage: UIImage, completionBlock : @escaping ((UIImage) -> Void)) {

        guard let url = URL(string: urlstring) else {
            self.image = placeholderImage
            return
        }
        self.sd_setImage(with: url, placeholderImage: placeholderImage, options: .highPriority) { (image, _, _, _) in
            if let img = image {
                completionBlock(img)
            } else {
                print("error occured")
            }
    }
}
    func storeImageToCache(urlstring: String) {
        SDImageCache.shared().removeImage(forKey: urlstring, withCompletion: nil)
        self.setImageWithUrl(urlstring: urlstring, placeholderImage: #imageLiteral(resourceName: "profileIcon"))
    }
}

func checkImageStoredInCacheFor(urlString: String) -> Bool {

    return SDImageCache.shared().diskImageDataExists(withKey: urlString)
}

func getCacheImage(urlString: String) -> UIImage? {
    if let image = SDImageCache.shared().imageFromDiskCache(forKey: urlString) {
        return image
    } else {
        return nil
    }
}

public extension UIImageView{
    
    func addImageBorderColorWidth(borderColor:UIColor,borderWidth:CGFloat){
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = self.frame.size.width * 0.5
        self.layer.masksToBounds = true
    }
}
