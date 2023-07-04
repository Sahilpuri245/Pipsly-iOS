//
//  FontConstants.swift
//  PIPSLY
//
//  Created by KiwiTech on 21/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation
import UIKit

// font constant name
let kBoldAppFont   = "Metropolis-Bold"
let kSemiboldAppFont = "Metropolis-SemiBold"

enum FontName : String {
    case Bold        = "Metropolis-Bold"
    case SemiBold    = "Metropolis-SemiBold"
    case Regular     = "Metropolis-Regular"
    
    var value:String{
        return self.rawValue
    }
}

let kToastRegularFont = UIFont(name: FontName.Regular.rawValue, size: 15)
