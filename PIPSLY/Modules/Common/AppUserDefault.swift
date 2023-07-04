//
//  AppUserDefault.swift
//  PIPSLY
//
//  Created by KiwiTech on 20/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation

enum UserDefaultKeys: String {
    case userObject = "userObject"
    case deviceToken   = "deviceToken"
    case isLoggedIn = "isLoggedIn"
}

class AppUserDefault {
    
    static let defaults: UserDefaults = UserDefaults.standard
    
    class func saveUserDefault(forKey key: UserDefaultKeys, value: Any) {
        defaults.set(value, forKey: key.stringValue)
    }
    
    class func getStringFromUserDefault(forKey key: UserDefaultKeys) -> String? {
        
        if let value = defaults.string(forKey: key.rawValue) {
            return value
        } else {
            return nil
        }
    }
    
    class func getObjectFromUserDefault(forKey key: UserDefaultKeys) -> Any? {
        
        if let value = defaults.object(forKey: key.rawValue) {
            return value
        } else {
            return nil
        }
    }
    
    class func getDataFromUserDefault(forKey key: UserDefaultKeys) -> Data? {
        if let value = defaults.data(forKey: key.rawValue) {
            return value
        } else {
            return nil
        }
    }
    
    class func getBoolFromUserDefault(forKey key: UserDefaultKeys) -> Bool? {
        return defaults.bool(forKey: key.rawValue)
    }
    
    class func clearUserDefault() {
        var token: String?
        if let deviceToken = AppUserDefault.getStringFromUserDefault(forKey: UserDefaultKeys.deviceToken) {
            token = deviceToken
        }
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
        if let token = token {
            AppUserDefault.saveUserDefault(forKey: UserDefaultKeys.deviceToken, value: token)
        }
    }
}

extension RawRepresentable where RawValue == String {
    var stringValue: String {
        return rawValue
    }
}
