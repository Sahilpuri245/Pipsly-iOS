//
//  BYBChangePasswordService.swift
//  PIPSLY
//
//  Created by KiwiTech on 05/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation

protocol BYBChangePasswordService:BYBService {
}
extension BYBChangePasswordService{
    //  to change password
    
    @discardableResult
    func  changePassword(_ currentPassword: String,_ newPassword:String, completion:@escaping (_ status:Bool, _ message:String?, _ error: Error?) -> Void ) -> ServiceRequest {
        var requestDict = [String:Any]()
        requestDict["current_password"] = currentPassword
        requestDict["new_password"] = newPassword
        let request = Request(url: APIURL.ChangePassword, method: .post, parameters: requestDict, encoding: JSONEncode.default, headersRequired: true)
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
    
    //  update email
    
    @discardableResult
    func  updateEmail(_ email: String,_ password:String, completion:@escaping (_ status:Bool, _ message:String?, _ error: Error?) -> Void ) -> ServiceRequest {
        var requestDict = [String:Any]()
        requestDict["email"] = email
        requestDict["password"] = password
        let request = Request(url: APIURL.UpdateEmail, method: .post, parameters: requestDict, encoding: JSONEncode.default, headersRequired: true)
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
