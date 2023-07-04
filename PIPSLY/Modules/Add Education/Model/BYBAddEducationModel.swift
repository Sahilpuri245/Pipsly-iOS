//
//  AddEducationModel.swift
//  PIPSLY
//
//  Created by KiwiTech on 12/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation
struct BYBAddEducationModel :BaseModel,Codable{

    var id :Int?
    var createdAt:String?
    var updatedAt:String?
    var year:String?
    var university:String?
    var studyField:String?
    var educationType:String?
    var brand:Int?
    
}

extension BYBAddEducationModel {
    enum keys:String, SerializationKey {
       
        case id = "brandId"
        case  createdAt = "created_at"
        case updatedAt = "updated_at"
        case year
        case university
        case studyField = "study_field"
        case educationType = "education_type"
        case brand
    }
    
    init(serialization:Serialization) {
        self.id = serialization.value(forKey: keys.id)
        self.createdAt = serialization.value(forKey: keys.createdAt)
        self.updatedAt = serialization.value(forKey: keys.updatedAt)
        self.year = serialization.value(forKey: keys.year)
        self.university = serialization.value(forKey: keys.university)
        self.studyField = serialization.value(forKey: keys.studyField)
        self.educationType = serialization.value(forKey: keys.educationType)
        self.brand = serialization.value(forKey: keys.brand)
}
}
