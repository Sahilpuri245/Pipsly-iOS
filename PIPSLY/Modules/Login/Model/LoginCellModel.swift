//
//  LoginCellModel.swift
//  PIPSLY
//
//  Created by KiwiTech on 29/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation

class LoginCellModel {
    
    var cellIdentifier:String?
    var cellType:LoginCellType
    
    init(cellID:String = "", cellType:LoginCellType = .loginCell ) {
        self.cellIdentifier = cellID
        self.cellType = cellType
    }
    
    class func createDataSourceForLogin() -> [LoginCellModel] {
        var arrLogin = [LoginCellModel]()
        
        let loginCellModel = LoginCellModel(cellID: "LoginCell", cellType: .loginCell)
        arrLogin.append(loginCellModel)
        
        let userTypeCellModel = LoginCellModel(cellID: "UserTypeCell", cellType: .userTypeCell)
        arrLogin.append(userTypeCellModel)
        return arrLogin
    }
    
}
