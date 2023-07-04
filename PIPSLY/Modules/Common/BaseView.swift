//
//  BaseView.swift
//  PIPSLY
//
//  Created by KiwiTech on 05/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

class BaseView: UIView, NibLoadableView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Class Function
    class func instanceFromNib() -> UIView {
        guard let view = UINib(nibName: self.NibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView else { return UIView()}
        return view
    }

}
