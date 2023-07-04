//
//  Service.swift
//  ROUTE
//
//  Created by Sumit Tripathi on 29/04/17.
//  Copyright © 2018 Route. All rights reserved.
//

import Foundation
import Alamofire

enum ErrorCodes: Int {
    case successCode = 200
    case successCodeEnd = 300
    case sessionExpired =  401
    case noInternet =  -1009
    case noInternetForOtherCase =  -1004
    case noInbox = 8888
    case requestTimeOut = 3840
    case requestCancel =  -999
    case accessDeniedForFreeUser =  403
}

typealias URLEncode = URLEncoding
typealias JSONEncode = JSONEncoding

let kRequestTimeOutMessage = "The request timed out."
//"TIMEOUTEXCEPTIONONCANCELREQUEST"

var alertVisible: Bool=false

var uploadRequest: ServiceRequest = ServiceRequest()

struct ServiceRequest {
    public var request: DataRequest?
    public func cancel() {
        request?.cancel()
    }
}

protocol Service: class {
    var baseServerUrl: String {get}
    var token: String {get}
    var isLogedIn: Bool {get}
}

struct Request {
    let url: String
    let method: HTTPMethod
    let parameters: Parameters?
    let encoding: ParameterEncoding!
    let headersRequired: Bool!
}

struct MultiPartRequest {
    let url: String
    let data: Data?
    let dataKey: String?
    let mimeType: String?
    let fileName: String?
    let method: HTTPMethod!
    let parameters: Parameters?
    let encoding: JSONEncoding!
    let headersRequired: Bool!
}

extension Service {

    ///Completion Handlers
    public typealias ErrorHandler = (HTTPURLResponse?, Error?) -> Void
    public typealias SuccessHandler = (HTTPURLResponse?, Any?) -> Void
    public typealias ProgressHandler = (Any?) -> Void

    public func requestWithoutValidate(request: Request,
                                       onSuccess: @escaping SuccessHandler,
                                       onError: @escaping ErrorHandler) -> ServiceRequest {
        var finalUrl: URL!
        do {
            var tempUrl = baseServerUrl
            tempUrl.append(request.url)
            finalUrl = try tempUrl.asURL()
        } catch {
            print(error)
        }

        var headers: HTTPHeaders? = nil
        if request.headersRequired == true {
            headers = [
                "Authorization": "Bearer \(token)", //For later use
                "device": "iPhone",
                "accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        } else {
            headers = [
                "device": "iPhone",
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }

        let request: DataRequest = Alamofire.request(finalUrl,
                                                     method: request.method,
                                                     parameters: request.parameters,
                                                     encoding: request.encoding,
                                                     headers: headers).responseJSON { (response) in
            switch response.result {

            case .success(let value) :

                print_debug("response: \(value)")

                onSuccess(response.response, value)

            case .failure(let err) :
                onError(response.response, err)
                print_debug("error: \(err)")

            }
        }

        let currentRequest: ServiceRequest = ServiceRequest(request: request)

        return currentRequest
    }

    /// This method will be used to request service using Alamofire
    public func requestWithRequestObject(_ request: Request,
                        onSuccess: @escaping SuccessHandler,
                        onError: @escaping ErrorHandler) -> ServiceRequest {
        var finalUrl: URL!
        do {
            var tempUrl = baseServerUrl
            tempUrl.append(request.url)
            finalUrl = try tempUrl.asURL()
        } catch {
            print(error)
        }

        var headers: HTTPHeaders? = nil
        if request.headersRequired == true {
            headers = [
                "Authorization": "Bearer \(token)", //For later use
                "device": "iPhone",
                "accept": "application/json"
            ]
        } else {
            headers = [
                "device": "iPhone",
                "accept": "application/json",
                "Content-Type": "application/json"
            ]
        }
        print_debug("\n\nAPI NAME --> \(finalUrl)\nRequest Parameters --> \(request.parameters)\n\n")
        print_debug("\n\nRequest Header --> \(headers)\n\n")

        let request: DataRequest = Alamofire.request(finalUrl,
                                                     method: request.method, parameters: request.parameters,
                                                     encoding: request.encoding,
                                                     headers: headers)
            .responseJSON { (response) in

                switch response.result {

                case .success(let value) :
                    
                    print_debug("response: \(value)")

                    if let code = response.response?.statusCode, code >= ErrorCodes.successCode.rawValue && code <= ErrorCodes.successCodeEnd.rawValue {
                        onSuccess(response.response, value)
                    } else if let code = response.response?.statusCode, code == ErrorCodes.sessionExpired.rawValue {
//                        self.sessionExpired(nil)
                    } else {
                        
                        if let resp = value as? [String: Any] {
                            if let errorMsg = resp["errors"] as? String {
                                let userInfo: [AnyHashable: Any] =
                                    [
                                        NSLocalizedDescriptionKey: NSLocalizedString("Error", value: errorMsg, comment: "") ,
                                        NSLocalizedFailureReasonErrorKey: NSLocalizedString("Error", value: errorMsg, comment: "")
                                ]
                                let errorFinal: NSError = NSError(domain: "Route", code: response.response?.statusCode ?? -1, userInfo: userInfo as? [String: Any])
                                onError(response.response, errorFinal)
                                return
                            } else if let errorMsg = resp["exception"] as? String {
                                let userInfo: [AnyHashable: Any] =
                                    [
                                        NSLocalizedDescriptionKey: NSLocalizedString("Error", value: errorMsg, comment: "") ,
                                        NSLocalizedFailureReasonErrorKey: NSLocalizedString("Error", value: errorMsg, comment: "")
                                ]
                                let errorFinal: NSError = NSError(domain: "Route", code: response.response?.statusCode ?? -1, userInfo: userInfo as? [String: Any])
                                onError(response.response, errorFinal)
                                return
                            }
                        }
                        onSuccess(response.response, value)
                    }
                case .failure(let error) :

                    print_debug("error: \(error)")

                    if (error as NSError).code == ErrorCodes.requestTimeOut.rawValue {
                        let err = error as NSError
                        let userInfo: [AnyHashable: Any] =
                            [
                                NSLocalizedDescriptionKey: NSLocalizedString("Error", value: kRequestTimeOutMessage, comment: "") ,
                                NSLocalizedFailureReasonErrorKey: NSLocalizedString("Error", value: kRequestTimeOutMessage, comment: "")
                        ]
                        let errorFinal: NSError = NSError(domain: err.domain, code: err.code, userInfo: userInfo as? [String: Any])
                        onError(response.response, errorFinal)
                        return
                    } else if((error as NSError).code == ErrorCodes.noInternet.rawValue) {

                        let err = error as NSError
                        let userInfo: [AnyHashable: Any] =
                            [
                                NSLocalizedDescriptionKey: NSLocalizedString("Error", value: CommonString.noInternetDescription.rawValue, comment: "") ,
                                NSLocalizedFailureReasonErrorKey: NSLocalizedString("Error", value: CommonString.noInternetDescription.rawValue, comment: "")
                        ]
                        let errorFinal: NSError = NSError(domain: err.domain, code: err.code, userInfo: userInfo as? [String: Any])
                        onError(response.response, errorFinal)
                        return
                    }

                    print_debug(error)
                    onError(response.response, error)
                }
        }
            .responseString { (responseMsg) in
                print(responseMsg.result.value)
        }
        let currentRequest: ServiceRequest = ServiceRequest(request: request)

        return currentRequest
    }

    /// This method will be used to request service using Alamofire
    public func requestDataWithMultipartWithProgress(request: MultiPartRequest,
                                                     onSuccess: @escaping SuccessHandler,
                                                     onError: @escaping ErrorHandler,
                                                     onProgress: @escaping ProgressHandler) {
        var finalUrl: URL!
        do {
            var tempUrl = baseServerUrl
            tempUrl.append(request.url)
            finalUrl = try tempUrl.asURL()
        } catch {
            print(error)
        }

        let headers: HTTPHeaders = [

            "Authorization": "Bearer \(token)", //For later use
            "device": "iPhone",
            "accept": "application/json"
        ]

        uploadRequest.cancel()
        uploadRequest.request = nil

        print_debug("\n\nAPI NAME --> \(finalUrl)\nRequest Parameters --> \(request.parameters)\n\n")
        print_debug("\n\nRequest Header --> \(headers)\n\n")

        Alamofire.upload(multipartFormData: { multipartFormData in

            let multipartData:MultipartFormData = multipartFormData as MultipartFormData

            if let data = request.data, let key = request.dataKey, let fileName = request.fileName, let mimtype = request.mimeType {
                multipartData.append(data, withName: key, fileName: fileName, mimeType: mimtype)
            }

            for (key, value) in request.parameters! {
                multipartData.append(String(describing: value).data(using: .utf8)!, withName: key)
            }

        }, to: finalUrl, method: request.method, headers: request.headersRequired == true ? headers : nil,
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                uploadRequest.request = upload

                upload.uploadProgress(closure: { (progress) in
                    onProgress(progress)
                })

                upload.response { [weak self] response in
                    if let error = response.error {
                        if let data = response.data {
                            do {
                                guard let errorResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Any else {
                                    print_debug("error trying to convert data to JSON")
                                    onError(response.response, error)
                                    return
                                }
                                var errorCode = 0
                                if let statusCode = response.response?.statusCode {
                                    errorCode = statusCode
                                } else {
                                    let tempError = error as NSError
                                    errorCode = tempError.code
                                }
                                if errorCode == ErrorCodes.sessionExpired.rawValue {
//                                    self?.sessionExpired(errorResult)
                                }
                                
                                let err = error as NSError
                                if let errorJson = errorResult as? Serialization {
                                    let errorFinal: NSError = NSError(domain: err.domain, code: errorCode, userInfo: errorJson)
                                    onError(response.response, errorFinal)
                                } else {
                                    onError(response.response, nil)
                                }
                            } catch {
                                print_debug("caught: \(error)")
                                if (error as NSError).code == ErrorCodes.requestTimeOut.rawValue {
                                    let err = error as NSError
                                    let userInfo: [AnyHashable: Any] =
                                        [
                                            NSLocalizedDescriptionKey: NSLocalizedString("Error", value: kRequestTimeOutMessage, comment: "") ,
                                            NSLocalizedFailureReasonErrorKey: NSLocalizedString("Error", value: kRequestTimeOutMessage, comment: "")
                                    ]
                                    let errorFinal: NSError = NSError(domain: err.domain, code: err.code, userInfo: userInfo as? [String: Any])
                                    onError(response.response, errorFinal)
                                    return
                                }
                                onError(response.response, error)
                                return
                            }
                        } else {
                            print_debug(error.localizedDescription)
                            onError(response.response, error)
                        }
                    } else {
                        if let data = response.data {

                            do {
                                guard let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Any else {
                                    print_debug("error trying to convert data to JSON")
                                    onSuccess(response.response, nil)
                                    return
                                }
                                if let code = response.response?.statusCode, code >= ErrorCodes.successCode.rawValue && code <= ErrorCodes.successCodeEnd.rawValue {
                                    onSuccess(response.response, jsonResult)
                                } else if let code = response.response?.statusCode, code == ErrorCodes.sessionExpired.rawValue {
//                                    self?.sessionExpired(nil)
                                } else {
                                    if let resp = jsonResult as? [String: Any] {
                                        if let errorMsg = resp["errors"] as? String {
                                            let userInfo: [AnyHashable: Any] =
                                                [
                                                    NSLocalizedDescriptionKey: NSLocalizedString("Error", value: errorMsg, comment: "") ,
                                                    NSLocalizedFailureReasonErrorKey: NSLocalizedString("Error", value: errorMsg, comment: "")
                                            ]
                                            let errorFinal: NSError = NSError(domain: "Route", code: response.response?.statusCode ?? -1, userInfo: userInfo as? [String: Any])
                                            onError(response.response, errorFinal)
                                            return
                                        }
                                    }
                                    onSuccess(response.response, jsonResult)
                                }
                            } catch {
                                print_debug("caught: \(error)")
                                onError(response.response, error)
                            }
                        }
                    }
                }
            case .failure(let encodingError):
                onError(nil, encodingError)
            }
        })
    }
}
