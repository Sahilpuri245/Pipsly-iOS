//
//  BYBSignupModel.swift
//  PIPSLY
//
//  Created by KiwiTech on 21/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

class SignupCellModel: NSObject {
    
    var placeholder:String!
    var value:String?
    var cellIdentifier:String
    var cellType:SignupCellType
    var cellSubtype:SignupCellSubType
    var cellHeight: CGFloat!
    var helpMsg:String!
    var isButtonHide:Bool!
    var imageName:String?
    var state: ValidityState!
    var errorMSg:String?
    
    init(placeholder:String = "" , value:String? , cellID:String = "" , cellType: SignupCellType = .nameCell, cellSubType: SignupCellSubType = .name, cellHeight: CGFloat = 65.0, msg:String = "",isHide:Bool = true,imageName:String = "",state:ValidityState = .none,error:String = "") {
        self.placeholder = placeholder
        self.value = value
        self.cellIdentifier = cellID
        self.cellType = cellType
        self.cellSubtype = cellSubType
        self.cellHeight = cellHeight
        self.helpMsg = msg
        self.isButtonHide = isHide
        self.imageName = imageName
        self.state = state
        self.errorMSg = error
    }
    
    static func getCellHeignt(_ cellSubType: SignupCellSubType) -> CGFloat {
        switch cellSubType {
        case .name ,.email,.birthday :
            return 65.0
        case .gender :
            return 45.0
        case .password,.address :
            return 101.0
        }
    }
    
    class func createDataSourceForSignp(userType:UserType) -> [SignupCellModel]
    {
        var arrSignup = [SignupCellModel]()
        let nameCell = SignupCellModel(placeholder: "Name", value: "", cellID: "SignupNameCell", cellType: .nameCell,cellSubType: .name ,cellHeight: SignupCellModel.getCellHeignt(.name),isHide:true)
        arrSignup.append(nameCell)
        
        let emailCell = SignupCellModel(placeholder: "Email", value: "", cellID: "SignupNameCell", cellType: .nameCell, cellSubType: .email, cellHeight: SignupCellModel.getCellHeignt(.email),isHide:true)
        arrSignup.append(emailCell)
        
        let passwordCell = SignupCellModel(placeholder: "Password", value: "", cellID: "SignupNameCell", cellType: .nameCell, cellSubType: .password, cellHeight: SignupCellModel.getCellHeignt(.password),msg:"Password must atleast have 8 characters, 1 uppercase and 1 numeric.",isHide:false)
        arrSignup.append(passwordCell)
        
        let genderCell = SignupCellModel(placeholder: "", value: nil, cellID: "SignupGenderCell", cellType: .genderCell, cellSubType: .gender, cellHeight: SignupCellModel.getCellHeignt(.gender))
        arrSignup.append(genderCell)
        
        let birthdayCell = SignupCellModel(placeholder: "When is your Birthday?(Optional)", value: "", cellID: "SignupNameCell", cellType: .nameCell, cellSubType: .birthday, cellHeight: SignupCellModel.getCellHeignt(.birthday),isHide:false,imageName:"iconCalendar")
        arrSignup.append(birthdayCell)
        
        let addressCell = SignupCellModel(placeholder: getPlaceholderForAddress(userType: userType), value: "", cellID: "SignupNameCell", cellType: .nameCell, cellSubType: .address, cellHeight: SignupCellModel.getCellHeignt(.address),msg:"Add a location so we could help you find services around you.",isHide:false,imageName:"iconLocation")
        arrSignup.append(addressCell)
        
        return arrSignup
    }
    
    // add for View profile
    class func createDataSourceForViewProfile() -> [SignupCellModel]
    {
        var arrSignup = [SignupCellModel]()
        let nameCell = SignupCellModel(placeholder: "Name", value: "", cellID: "SignupNameCell", cellType: .nameCell,cellSubType: .name ,cellHeight: SignupCellModel.getCellHeignt(.name),isHide:true)
        arrSignup.append(nameCell)
        
        let birthdayCell = SignupCellModel(placeholder: "When is your Birthday?(Optional)", value: "", cellID: "SignupNameCell", cellType: .nameCell, cellSubType: .birthday, cellHeight: SignupCellModel.getCellHeignt(.birthday),isHide:false,imageName:"iconCalendar")
        arrSignup.append(birthdayCell)
        
        
        let addressCell = SignupCellModel(placeholder: "Where do you live?", value: "", cellID: "SignupNameCell", cellType: .nameCell, cellSubType: .address, cellHeight: SignupCellModel.getCellHeignt(.address),isHide:false,imageName:"iconLocation")
        arrSignup.append(addressCell)
        let genderCell = SignupCellModel(placeholder: "", value: nil, cellID: "SignupGenderCell", cellType: .genderCell, cellSubType: .gender, cellHeight: SignupCellModel.getCellHeignt(.gender))
        arrSignup.append(genderCell)
        
        return arrSignup
    }
    
    
    class func getPlaceholderForAddress(userType:UserType) -> String {
        var str = ""
        switch userType {
        case .buyer:
            str = "Where do you live?"
        case .brand:
             str = "Work address"
        default:
            break
        }
        return str
    }
}
