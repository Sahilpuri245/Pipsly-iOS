//
//  Validity.swift
//  ROUTE
//
//  Created by KiwiTech on 1/29/18.
//  Copyright © 2018 Route. All rights reserved.
//

import Foundation

enum FieldOption {
    case name, dob
}

class Validity {

    class func emptyFieldCheck(text: String?) -> (state: ValidityState, msg: String) {
        let finalText = text?.trimmingCharacters(in: .whitespaces)
        if let txt = finalText, !txt.isEmpty {
            return (ValidityState.valid, "")
        } else {
            return (ValidityState.invalid, "This field can't be left blank.")
        }
    }

    class func errorHandlingForUploadVideoImageCell() -> (state: ValidityState, msg: String) {
        return (ValidityState.invalid, "Please upload video of your product.")
    }

    class func errorHandlingForNorCell() -> (state: ValidityState, msg: String) {
        return (ValidityState.invalid, "Please select your payment account.")
    }

    class func validateName(text: String) -> (state: ValidityState, msg: String) {
        return (ValidityState.valid, "")
    }

    class func validateBirthDay(date: Date?) -> (state: ValidityState, msg: String) {
        guard let dt = date else {
            return (ValidityState.invalid, "This field can't be left blank.")
        }

        if Date().yearsBetweenDate(dt, endDate: Date()) < 21 {
            return (ValidityState.invalid, "Age should be 21 years or above.")
        } else {
            return (ValidityState.valid, "")
        }
    }

    class func validateCvvOfCard(text: String?) -> (state: ValidityState, msg: String) {

        let validity = emptyFieldCheck(text: text)
        if validity.state == .invalid {
            return validity
        } else {
            if let txt = text, txt.count > 2 {
                return (ValidityState.valid, "")
            } else {
                return (ValidityState.invalid, "Enter valid cvv number.")
            }
        }
    }

    class func validateBankAccountNo(text: String) -> (state: ValidityState, msg: String) {

            if text.count < 11  || text.count > 18 {
                return (ValidityState.invalid, "Enter valid Bank account number.")
            } else {
                return (ValidityState.valid, "")
            }
    }

    class func validateBankRoutingNo(text: String) -> (state: ValidityState, msg: String) {

        if text.count < 9 {
            return (ValidityState.invalid, "Enter valid Bank routing number.")
        } else {
            return (ValidityState.valid, "")
        }
    }

    class func validateCardNumber(text: String?) -> (state: ValidityState, msg: String) {

        let validity = emptyFieldCheck(text: text)
        if validity.state == .invalid {
            return validity
        } else {
            if let txt = text, txt.count > 16 {
                return (ValidityState.valid, "")
            } else {
                return (ValidityState.invalid, "Enter valid card number.")
            }
        }
    }

    class func validateExpiryMothOfCard(month: String, year: String) -> (state: ValidityState, msg: String) {

        let expiry = "28," + month + "," + year

        if let expiryDate = Utility.getDateFromString(expiry, withFormat: "dd,MM,yyyy") {

            let currentDate = Date()
            let monthDiff = Calendar.current.dateComponents([.month], from: currentDate, to: expiryDate).month ?? 0

            if monthDiff > 0 {
                return (ValidityState.valid, "")
            } else {
                return (ValidityState.invalid, "Enter valid expiry month.")
            }

        } else {
            return (ValidityState.valid, "")
        }
    }
}
