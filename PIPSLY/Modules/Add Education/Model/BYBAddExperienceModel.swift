//
//  BYBAddExperienceModel.swift
//  PIPSLY
//
//  Created by KiwiTech on 12/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation
struct BYBAddExperienceModel :BaseModel,Codable{
    var id :Int?
    var created_at:String?
    var updated_at:String?
    var designation:String?
    var business:String?
    var location:String?
     var start_year:String?
    var end_year:String?
    var brand:Int?
    
}

extension BYBAddExperienceModel {
    enum keys:String, SerializationKey {
        
        case id = "brandId"
        case created_at = "createdAt"
        case updated_at = "updatedAt"
        case designation
        case business
        case location
        case start_year = "startYear"
        case end_year = "endYear"
        
        case brand
    }
    
    init(serialization:Serialization) {
        self.id = serialization.value(forKey: keys.id)
        self.created_at = serialization.value(forKey: keys.created_at)
        self.updated_at = serialization.value(forKey: keys.updated_at)
        self.designation = serialization.value(forKey: keys.designation)
        self.business = serialization.value(forKey: keys.business)
        self.location = serialization.value(forKey: keys.location)
        self.start_year = serialization.value(forKey: keys.start_year)
        self.end_year = serialization.value(forKey: keys.end_year)
        self.brand = serialization.value(forKey: keys.brand)
    }
}
