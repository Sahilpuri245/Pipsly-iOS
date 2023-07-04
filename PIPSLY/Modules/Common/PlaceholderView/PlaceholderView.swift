//
//  PlaceholderView.swift
//  PIPSLY
//
//  Created by KiwiTech on 10/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

class PlaceholderView: BaseView {

    @IBOutlet weak var imgView: UIImageView?
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var lblMsg: UILabel?
    
    
    func setupViewWithData(imgName:String = "", title:String?, msg:String?)  {
        self.imgView?.image = UIImage.init(named: imgName)
        self.lblTitle?.text = title
        self.lblMsg?.text = msg
    }
    
}
