//
//  BYBSignupService.swift
//  PIPSLY
//
//  Created by KiwiTech on 26/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation
import Alamofire

protocol BYBSignupService:BYBService {}

extension BYBSignupService {
    @discardableResult
    func  signUp(_ signUpObj: SignupModel, completion:@escaping (_ status:Bool, _ message:String?, _ user: [String:Any]?, _ error: Error?) -> Void ) -> ServiceRequest {
        let requestDict = signUpObj.toDictionary() ?? [:]
        let request = Request(url: APIURL.signUp, method: .post, parameters: requestDict, encoding: JSONEncode.default, headersRequired: false)
        let requestObj = requestWithRequestObject(request, onSuccess: { (_, jsonRes) in
            if let json = jsonRes as? Serialization {
                let respoObj = ResponceSerialization(serialization: json)
                if respoObj.status_code == APIStatusCode.successCode.rawValue || respoObj.status_code == APIStatusCode.successCodeCreation.rawValue{
                    if let user = respoObj.result {
                        completion(true,respoObj.message,user,nil)
                    }
                } else {
                    completion(false,respoObj.message,nil, nil)
                }
            }else {
                completion(false,CommonString.parseError.rawValue,nil, nil)
            }
        }) { (_, error) in
            completion(false,nil,nil, error)
        }
        return requestObj
    }
    
    @discardableResult
    func  verifyEmail(_ strEmail:String?, completion:@escaping (_ status:Bool, _ message:String?, _ error: Error?) -> Void ) -> ServiceRequest {
        var requestDict = [String:Any]()
        requestDict["email"] = strEmail
        
        let request = Request(url: APIURL.resendEmail, method: .post, parameters: requestDict, encoding: JSONEncode.default, headersRequired: false)
        let requestObj = requestWithRequestObject(request, onSuccess: { (_, jsonRes) in
            if let json = jsonRes as? Serialization {
                let respoObj = ResponceSerialization(serialization: json)
                if respoObj.status_code == APIStatusCode.successCode.rawValue {
                    completion(true,respoObj.message,nil)
                } else {
                    completion(false,respoObj.message,nil)
                }
            }else {
                completion(false,CommonString.parseError.rawValue,nil)
            }
        }) { (_, error) in
            completion(false,nil, error)
        }
        return requestObj
    }
    
    @discardableResult
    func categories(completion:@escaping (_ status:Bool, _ message:String?, _ user: [InterestCategoryModel]?, _ error: Error?) -> Void ) -> ServiceRequest {
        let request = Request(url: APIURL.categories, method: .get, parameters: nil, encoding: JSONEncode.default, headersRequired: true)
        let requestObj = requestWithRequestObject(request, onSuccess: { (_, jsonRes) in
            if let json = jsonRes as? Serialization {
                let respoObj = ResponceSerialization(serialization: json)
                if respoObj.status_code == APIStatusCode.successCode.rawValue{
                    if let list = respoObj.list {
                        let categoryList = self.getCategoryList(list: list)
                        completion(true,respoObj.message,categoryList,nil)
                    }
                } else {
                    completion(false,respoObj.message,nil, nil)
                }
            }else {
                completion(false,CommonString.parseError.rawValue,nil, nil)
            }
        }) { (_, error) in
            completion(false,nil,nil, error)
        }
        return requestObj
    }
    
    func uploadProfileImage(imageData:Data?, completion:@escaping (_ status: Bool, _ image: UIImage?,_ message:String?, _ error: Error?) -> Void ) {
        
        guard let userID = AppManager.shared().userObj.userID else {return}
        let finalUrl = "auth/users/" + "\(userID)/"
        
        let multiRequest = MultiPartRequest(url: finalUrl, data: imageData, dataKey: "profile_picture", mimeType: "image/png", fileName: "image.jpg", method: .patch, parameters: [:], encoding: JSONEncoding.default, headersRequired: true)
        
        requestDataWithMultipartWithProgress(request: multiRequest, onSuccess: { (_, jsonRes) in
            if let json = jsonRes as? Serialization {
                
                let respoObj = ResponceSerialization(serialization: json)
                if  respoObj.status_code == APIStatusCode.successCode.rawValue {
                    if let _ = respoObj.result {
                        completion(true, UIImage(),respoObj.message, nil)
                    }
                } else {
                    completion(false, nil,respoObj.message, nil)
                }
            }
        }, onError: { (_, error) in
            completion(false, nil,nil, error)
        }) { (progress) in
            if let _ = progress as? Progress {
            }
        }
    }
    
    func getCategoryList(list:[Serialization]) -> [InterestCategoryModel] {
        var arrCategory = [InterestCategoryModel]()
        for category in list {
            let model = InterestCategoryModel(serialization: category)
            arrCategory.append(model)
        }
        return arrCategory
    }

    @discardableResult
    func selectCategories(_ categories: [Int]?, completion:@escaping (_ status:Bool, _ message:String?, _ error: Error?) -> Void ) -> ServiceRequest {
        guard let arr = categories else {return ServiceRequest()}
        var requestDict = [String:Any]()
        requestDict["specialization_area"] = arr
        let request = Request(url: APIURL.categorySpecialization, method: .post, parameters: requestDict, encoding: JSONEncode.default, headersRequired: true)
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
