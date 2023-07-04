//
//  BaseVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 21/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

class BaseVC: UIViewController, ShowsAlert {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func seachBarColorChange(){
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue:UIColor.black,NSAttributedStringKey.font.rawValue:UIFont(name: "Metropolis-Bold", size: 14.0)!]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = kLightGrayColor
        
    }


}
