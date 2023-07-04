//
//  APIEndpoints.swift
//  PIPSLY
//
//  Created by KiwiTech on 30/04/17.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation

struct Server {
    static var currentServer = BaseUrlType.testing
}

enum BaseUrlType {
    case development, testing, staging, production, local

    //All the PHP Servers path
    var pythonBaseServerUrl: String {
        switch self {
        case .development:
            return "http://52.2.189.69:8000/"
        case .testing:
            return "http://54.152.36.110:8000/"
        case .staging:
            return "http://stage.myroute.xyz"
        case .production:
            return "https://prod.myroute.xyz"
        case .local:
            return "http://52.2.189.69:8000/"
        }
    }
}

//ALL PHP API end points
struct APIURL {

    static var baseUrl: String = Server.currentServer.pythonBaseServerUrl
    static var token: String {
        return AppManager.shared().userObj.token?.accessToken ?? ""
    }
    static var isLogin: Bool {
        return AppManager.shared().isLogedIn
    }
    static var signUp:String {
        return "auth/users/"
    }
    static var resendEmail:String {
        return "auth/users/resend-email/"
    }
    static var login:String {
        return "auth/login/"
    }
    static var forgotPassword:String {
        return "auth/forget-password/"
    }
    // change Password APi
    static var ChangePassword:String{
        return "auth/change-password/"
    }
    // update Email Api
    static var UpdateEmail:String{
        return "auth/users/update-email/"
    }
    static var categories:String {
        return "specialization/categories/"
    }
    static var categorySpecialization:String {
        return "specialization/categories/"
    }
    // search brand
    static var SearchBrands:String{
        return "search/brands/"
    }
    // search businesses
    static var SearchBusinesses:String{
        return "search/businesses/"
    }
    
    // Create Brand Education
    
    static var CreateBrandEducation:String{
        return  "brand/educations/"
    }
    // create brand Experience
    static var CreateBrandExperience:String{
        return "/brand/experiences"
    }
}


