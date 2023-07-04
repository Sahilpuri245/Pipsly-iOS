//
//  BYBUser.swift
//  PIPSLY
//
//  Created by KiwiTech on 26/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation

struct TokenModel:BaseModel,Codable {
    var accessToken: String?
    var expires_in: String?
    var refresh_token:String?
    
    enum keys:String, SerializationKey {
        case accessToken = "access_token"
        case expires_in
        case refresh_token
    }
    
    init(serialization:Serialization) {
        self.accessToken = serialization.value(forKey: keys.accessToken)
        self.expires_in = serialization.value(forKey: keys.expires_in)
        self.refresh_token = serialization.value(forKey: keys.refresh_token)
    }
}

struct BYBUser:BaseModel,Codable {
    var email:String?
    var userID:Int?
    var token:TokenModel?
    var userType:String?
    var name:String?
    var profilePic:String?
    var address:AddressModel?
    var isFirstLogin:Bool = true
}

extension BYBUser {
    enum keys:String, SerializationKey {
        case userType = "user_type"
        case email
        case token
        case userID = "id"
        case name
        case profilePic = "profile_picture"
        case address
    }
    
    init(serialization:Serialization) {
        self.email = serialization.value(forKey: keys.email)
        self.userType = serialization.value(forKey: keys.userType)
        self.userID = serialization.value(forKey: keys.userID)
        self.name = serialization.value(forKey: keys.name)
        self.profilePic = serialization.value(forKey: keys.profilePic)
        let tokenDict:Serialization? = serialization.value(forKey: keys.token)
        if let dict = tokenDict {
            self.token = TokenModel(serialization: dict)
        }
        let addressDict:Serialization? = serialization.value(forKey: keys.address)
        if let address = addressDict {
            self.address = AddressModel(serialization: address)
        }
    }
    
    func saveDataInUserDefault() {
        let encodedData = try?  PropertyListEncoder().encode(self)
        AppUserDefault.saveUserDefault(forKey: UserDefaultKeys.userObject, value: encodedData as Any)
    }
    
}
