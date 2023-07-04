//
//  SignUpModel.swift
//  PIPSLY
//
//  Created by KiwiTech on 22/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation

struct AddressModel:BaseModel, Codable {
    var name:String?
    var latitude:Double?
    var longitude:Double?
    
    private enum keys:String, SerializationKey {
        case name
        case latitude
        case longitude
    }
    
    init(serialization: Serialization) {
        self.name = serialization.value(forKey: keys.name)
        self.latitude = serialization.value(forKey: keys.latitude)
        self.longitude = serialization.value(forKey: keys.longitude)
    }
}

struct SignupModel: Codable {
    var name:String?
    var email:String?
    var gender:String?
    var profile_picture:String?
    var dob:String?
    var user_type:String?
    var address:AddressModel?
    var password:String?
    
    init() {
        self.address = AddressModel(serialization: [:])
    }
    
    func toDictionary() -> [String:Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
            return dict
        } catch {
            return nil
        }
    }
    
    func serializeObject(_ obj: Any) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: JSONSerialization.WritingOptions.prettyPrinted)
            if let jsonStr = String(data: jsonData, encoding: String.Encoding.utf8) {
                return jsonStr
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
}


