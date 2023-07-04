//
//  TopBrandModel.swift
//  PIPSLY
//
//  Created by KiwiTech on 10/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation

struct TopBrandModel:BaseModel {
    var userID:Int?
    var name:String?
    var profilePic:String?
    var userType:String?
    var specialization:[String]?
    
    private enum keys:String,SerializationKey {
        case name
        case userID = "id"
        case profilePic = "profile_picture"
        case userType = "user_type"
        case specialization
    }
    
    init(serialization: Serialization) {
        self.userID = serialization.value(forKey: keys.userID)
        self.name = serialization.value(forKey: keys.name)
        self.profilePic = serialization.value(forKey: keys.profilePic)
        self.userType = serialization.value(forKey: keys.userType)
        self.specialization = serialization.value(forKey: keys.specialization)
    }
    
}
