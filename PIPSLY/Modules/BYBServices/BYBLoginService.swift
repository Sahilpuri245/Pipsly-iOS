//
//  BYBLoginService.swift
//  PIPSLY
//
//  Created by KiwiTech on 30/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation

protocol BYBLoginService:BYBService {
}

extension BYBLoginService {
    @discardableResult
    func  login(_ loginObj: LoginModel, completion:@escaping (_ status:Bool, _ message:String?, _ user: BYBUser?, _ error: Error?) -> Void ) -> ServiceRequest {
        var requestDict = [String:Any]()
        requestDict["email"] = loginObj.email
        requestDict["password"] = loginObj.password

        let request = Request(url: APIURL.login, method: .post, parameters: requestDict, encoding: JSONEncode.default, headersRequired: false)
        let requestObj = requestWithRequestObject(request, onSuccess: { (_, jsonRes) in
            if let json = jsonRes as? Serialization {
                let respoObj = ResponceSerialization(serialization: json)
                if respoObj.status_code == APIStatusCode.successCode.rawValue || respoObj.status_code == APIStatusCode.successCodeCreation.rawValue {
                    if let user = respoObj.result {
                        let user = BYBUser(serialization: user)
                        AppManager.shared().userObj = user
                        completion(true,respoObj.message,user,nil)
                    }
                } else {
                    completion(false,respoObj.message,nil, nil)
                }
            } else {
                completion(false,CommonString.parseError.rawValue,nil, nil)
            }
            
        }) { (_, error) in
            completion(false,nil,nil, error)
        }
        return requestObj
    }
    
    @discardableResult
    func  forgotPassword(_ email: String, completion:@escaping (_ status:Bool, _ message:String?, _ error: Error?) -> Void ) -> ServiceRequest {
        var requestDict = [String:Any]()
        requestDict["email"] = email
        
        let request = Request(url: APIURL.forgotPassword, method: .post, parameters: requestDict, encoding: JSONEncode.default, headersRequired: false)
        let requestObj = requestWithRequestObject(request, onSuccess: { (_, jsonRes) in
            if let json = jsonRes as? Serialization {
                let respoObj = ResponceSerialization(serialization: json)
                if respoObj.status_code == APIStatusCode.successCode.rawValue || respoObj.status_code == APIStatusCode.successCodeCreation.rawValue {
                        completion(true,respoObj.message,nil)
                } else {
                    completion(false,respoObj.message, nil)
                }
            }else {
                completion(false,CommonString.parseError.rawValue,nil)
            }
        }) { (_, error) in
            completion(false,nil, error)
        }
        return requestObj
    }
    
}
