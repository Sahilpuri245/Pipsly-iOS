//
//  AppManager.swift
//  PIPSLY
//
//  Created by KiwiTech on 20/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
import GooglePlaces
import GoogleMaps

class AppManager {
    
    fileprivate static var sharedObject: AppManager = AppManager()
    private var _userObj:BYBUser = BYBUser()
    var userType:UserType = .buyer
    private var _isLogedIn: Bool=false
    var isLogedIn: Bool {
        get {
            return _isLogedIn
        }
        set(newValue) {
            _isLogedIn = newValue
        }
    }
    
    private init() {}
    class func shared() -> AppManager {
        return sharedObject
    }
    
    var userObj:BYBUser {
        get{
            return _userObj
        }
        set(newValue) {
            self._userObj = newValue
            _userObj.saveDataInUserDefault()
        }
    }
    
    func initApplication() {
        UIApplication.shared.statusBarStyle = .lightContent
        Thread.sleep(forTimeInterval: 1.0)
        initKeyboard()
        setLoginRoot()
        GMSServices.provideAPIKey(GoogleAPiKey.key.rawValue)
        GMSPlacesClient.provideAPIKey(GoogleAPiKey.key.rawValue)
    }
    
    func initKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
    }
    
    func setLoginRoot()  {
        
        let stroyboard = UIStoryboard(name: StoryBoard.login.rawValue, bundle: nil)
        let navVC =  stroyboard.instantiateViewController(withIdentifier: kNavVC) as? UINavigationController
        if let appdelegate = UIApplication.shared.delegate  as? AppDelegate {
            appdelegate.window?.rootViewController = navVC
            appdelegate.window?.makeKeyAndVisible()
        }
        
    }
    
    
}
