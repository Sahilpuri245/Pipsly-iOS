//
//  BYBBrandsModel.swift
//  PIPSLY
//
//  Created by KiwiTech on 06/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation


struct BYBBrandsModel:BaseModel {
    var pk:Int?
    var name:String?
    var profilePic:String?
    var rating:String?
    var specialization:[String]?
    
    init(serialization: Serialization) {
        self.pk = serialization.value(forKey: keys.pk)
        self.name = serialization.value(forKey: keys.name)
        self.profilePic = serialization.value(forKey: keys.profilePic)
        self.specialization = serialization.value(forKey: keys.specialization)
        self.rating = serialization.value(forKey: keys.rating)
        
    }

}

extension BYBBrandsModel {
    enum keys:String, SerializationKey {
        case pk
        case name
        case profilePic = "profile_picture"
        case specialization
        case rating
    }
}
