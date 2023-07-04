//
//  BYBTopBrandService.swift
//  PIPSLY
//
//  Created by KiwiTech on 10/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation

protocol BYBTopBrandService:BYBService {}

extension BYBTopBrandService {
    @discardableResult
    func getTopBrands(_ userId: Int?, completion:@escaping (_ status:Bool, _ message:String?, _ brandList: [TopBrandModel]?, _ error: Error?) -> Void ) -> ServiceRequest {
        guard let userID = userId else { return ServiceRequest() }
        let finalUrl = "buyers/" + "\(userID)" + "/top-brands/"
        
        let request = Request(url: finalUrl, method: .get, parameters: nil, encoding: JSONEncode.default, headersRequired: true)
        let requestObj = requestWithRequestObject(request, onSuccess: { (_, jsonRes) in
            if let json = jsonRes as? Serialization {
                let respoObj = ResponceSerialization(serialization: json)
                if respoObj.status_code == APIStatusCode.successCode.rawValue || respoObj.status_code == APIStatusCode.successCodeCreation.rawValue{
                    if let list = respoObj.list {
                        let brandList = self.getBrandsList(list: list)
                        completion(true,respoObj.message,brandList,nil)
                    } else {
                        completion(true,respoObj.message,nil,nil)
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
    
    func getBrandsList(list:[Serialization]) -> [TopBrandModel] {
        var arrBrand = [TopBrandModel]()
        for brand in list {
            let model = TopBrandModel(serialization: brand)
            arrBrand.append(model)
        }
        return arrBrand
    }
    
}
