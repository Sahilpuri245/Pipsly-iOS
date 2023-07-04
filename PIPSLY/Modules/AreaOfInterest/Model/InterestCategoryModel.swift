//
//  InterestCategoryModel.swift
//  PIPSLY
//
//  Created by KiwiTech on 07/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

struct InterestCategoryModel:BaseModel {
    
    var id:Int?
    var name:String?
    var isSelected:Bool = false
    
    private enum keys:String, SerializationKey {
        case id
        case name
    }
    
    init(serialization: Serialization) {
        self.id = serialization.value(forKey: keys.id)
        self.name = serialization.value(forKey: keys.name)
    }

}
