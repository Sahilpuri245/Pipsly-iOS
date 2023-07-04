//
//  BYBAddBrandEducationService.swift
//  PIPSLY
//
//  Created by KiwiTech on 12/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation

protocol  BYBAddBrandEducationService:BYBService {
}
extension  BYBAddBrandEducationService{
    /// brands Education
    
    @discardableResult
    func  addBrandEducation(addEducationObj:[String:Any], completion:@escaping (_ status:Bool, _ message:String?, _ addEducationResult: BYBAddEducationModel?, _ error: Error?) -> Void ) -> ServiceRequest {
        let requestDict = addEducationObj
        
        let request = Request(url: APIURL.CreateBrandEducation, method: .post, parameters: requestDict, encoding: JSONEncode.default, headersRequired: false)
        let requestObj = requestWithRequestObject(request, onSuccess: { (_, jsonRes) in
            if let json = jsonRes as? Serialization {
                let respoObj = ResponceSerialization(serialization: json)
                if respoObj.status_code == APIStatusCode.successCode.rawValue || respoObj.status_code == APIStatusCode.successCodeCreation.rawValue {
                    if let addEducationResult = respoObj.result {
                  
                         let  addEducationResult = BYBAddEducationModel(serialization: addEducationResult)
                        
                        completion(true,respoObj.message,addEducationResult,nil)
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
    
    
    
    /// brands Experience
    
    @discardableResult
    func  addBrandExperience(addExperienceObj:[String:Any], completion:@escaping (_ status:Bool, _ message:String?, _ addExperienceResult: BYBAddExperienceModel?, _ error: Error?) -> Void ) -> ServiceRequest {
        let requestDict = addExperienceObj
        
        let request = Request(url: APIURL.CreateBrandExperience, method: .post, parameters: requestDict, encoding: JSONEncode.default, headersRequired: false)
        let requestObj = requestWithRequestObject(request, onSuccess: { (_, jsonRes) in
            if let json = jsonRes as? Serialization {
                let respoObj = ResponceSerialization(serialization: json)
                if respoObj.status_code == APIStatusCode.successCode.rawValue || respoObj.status_code == APIStatusCode.successCodeCreation.rawValue {
                    if let addExperienceResult = respoObj.result {
                        
                        let  addExperienceResult = BYBAddExperienceModel(serialization: addExperienceResult)
                        
                        completion(true,respoObj.message,addExperienceResult,nil)
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
    
    
}
