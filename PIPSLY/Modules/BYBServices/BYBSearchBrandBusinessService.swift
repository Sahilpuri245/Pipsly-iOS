//
//  BYBSearchBrandBusinessService.swift
//  PIPSLY
//
//  Created by KiwiTech on 06/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation

protocol BYBSearchBrandBusinessService:BYBService {
}
extension BYBSearchBrandBusinessService{
    /// brands search
    
    @discardableResult
    func searchBrands(url:String?,searchBrandsObj:[String:Any], completion:@escaping (_ status:Bool, _ message:String?, _ bussinessResult: [BYBBrandsModel]?, _ error: Error?) -> Void ) -> ServiceRequest {
        
        guard let finalUrl = url else {return ServiceRequest()}
       let requestDict = searchBrandsObj
        let request = Request(url: finalUrl, method: .get, parameters: requestDict, encoding: URLEncode.queryString, headersRequired: true)
        let requestObj = requestWithRequestObject(request, onSuccess: { (_, jsonRes) in
            if let json = jsonRes as? Serialization {
                let respoObj = ResponceSerialization(serialization: json)
                if respoObj.status_code == APIStatusCode.successCode.rawValue || respoObj.status_code == APIStatusCode.successCodeCreation.rawValue {
                    if let businessResult = respoObj.list {
                        let brandList = self.getBrandList(list: businessResult)
                        completion(true,respoObj.message,brandList,nil)
                    }
                    else {
                        completion(true,respoObj.message,nil,nil)
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
    
    func getBrandList(list:[Serialization]) -> [BYBBrandsModel] {
        var arrBrand = [BYBBrandsModel]()
        for category in list {
            let model = BYBBrandsModel(serialization: category)
            arrBrand.append(model)
        }
        return arrBrand
    }
}

