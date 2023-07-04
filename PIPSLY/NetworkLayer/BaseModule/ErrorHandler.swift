//
//  ErrorHandler.swift
//  ROUTE
//
//  Created by Amol on 30/04/17.
//  Copyright © 2017 KiwiTech. All rights reserved.
//

import Foundation

enum ErrorType {
    case none
    case noNetwork
    case serviceFailed
}

class ErrorInfo: Error {

    // this stores the actual data, do not access it directly, consider it private
    private var _errorMessage: String = ""
    private var _errorCode: Int = 0
    private var _localisedDescriptionMessage: String = ""
    private var _debugDescriptionMessage: String = ""
    var requestObject: AnyObject!

    var errorMessage: String {
        set { _errorMessage = newValue }
        get { return _errorMessage}
    }

    var errorCode: Int {
        set { _errorCode = newValue }
        get { return _errorCode}
    }

    var localisedDescriptionMessage: String {
        set { _localisedDescriptionMessage = newValue }
        get { return _localisedDescriptionMessage}
    }

    var debugDescriptionMessage: String {
        set { _debugDescriptionMessage = newValue }
        get { return _debugDescriptionMessage}
    }

    init(errorMessage errMessage: String, withLocalisedDescription localizedDescription: String, withDebugDescriptionMessage debugDescription: String, withErrorCode errorcode: Int) {
        errorCode = errorcode
        errorMessage = errMessage
        _debugDescriptionMessage = debugDescription
        localisedDescriptionMessage = localizedDescription
    }
}

extension Error {
    func getErrorType() -> ErrorType {
        var errorType: ErrorType = .none
        if (self as NSError).code == -1004 || (self as NSError).code == -1009 {
            errorType = .noNetwork
        } else {
            errorType = .serviceFailed
        }
        return errorType
    }

    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}

class ErrorHandler {

    func getErrorInfo(forError error: NSError?, forErrorType errorType: ErrorType) -> ErrorInfo {
        var errorInfo: ErrorInfo?
        let errorMessage: String = getErrorMessage(forError: error, forErrorType: errorType)
        let errorCode = error?.code
        if error != nil {
            errorInfo = ErrorInfo(errorMessage: errorMessage, withLocalisedDescription: (error?.localizedDescription)!, withDebugDescriptionMessage: (error?.debugDescription)!, withErrorCode: errorCode!)
        } else {
            errorInfo = ErrorInfo(errorMessage: errorMessage, withLocalisedDescription: " ", withDebugDescriptionMessage: " ", withErrorCode: errorCode!)
        }
        return errorInfo!
    }

    private func getErrorMessage(forError error: NSError?, forErrorType errorType: ErrorType) -> String {
        var errMsg: String = "Unable to process request, please try again."
        switch errorType {
        case .none:
            break
        case .noNetwork:
            errMsg = CommonString.noInternetDescription.rawValue
            break
        case .serviceFailed:
            errMsg = getErrorMessageforErrorCodes(error)
            break
        }
        return errMsg
    }

    private func getErrorMessageforErrorCodes(_ error: NSError?) -> String {
        var errMsg: String = "Unable to process request, please try again."
        let errorCode = error?.code
        switch errorCode {
        default:
            errMsg = parseErrorMessage(error)
        }
        return errMsg
    }

    private func parseErrorMessage(_ error: NSError?) -> String {
        let dict: [AnyHashable: Any]? = error?.userInfo
        var messageString: String? = "Unable to process request, please try again."
        if let infoObj = dict?["errors"] {
            if infoObj is String {
                messageString = infoObj as? String
            } else {
                if !(infoObj is NSNull) {
                    if let inObj = infoObj as? Array<Any> {
                        if inObj.count > 0 {
                            messageString = (infoObj as? Array<Any>)?.first as? String
                        }
                    } else {
                        messageString = error?.localizedDescription
                    }
                } else {
                    messageString = error?.localizedDescription
                }
            }
        } else if let infoObj = dict?["message"] {
            messageString = infoObj as? String
        } else if let infoObj = dict?["detail"] {
            messageString = infoObj as? String
        } else {
            if error?.code == -1004 || error?.code == -1009 {
                messageString = CommonString.noInternetDescription.rawValue
            } else {
                messageString = error?.localizedDescription
            }
        }
        if messageString == nil {
            messageString = "Unable to process request, please try again."
        }
        return messageString!

    }
}
