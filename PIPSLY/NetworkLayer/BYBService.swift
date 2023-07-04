//
//  BYBService.swift
//  PIPSLY
//
//  Created by KiwiTech on 24/10/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation
import UIKit

protocol BYBService: Service {}

extension BYBService {
    
    public var token: String {
        return APIURL.token
    }
    public var isLogedIn: Bool {
        return APIURL.isLogin
    }
    public var baseServerUrl: String {
        return APIURL.baseUrl
    }

}
