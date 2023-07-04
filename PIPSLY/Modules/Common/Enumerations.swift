//
//  Enumerations.swift
//  PIPSLY
//
//  Created by KiwiTech on 21/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation

enum YearPassed:Int{
    case startYear = 101
    case endYear = 102
}

enum GradientDirection {
    case vertical
    case horizontal
    case diagnol
}

enum SignupCellType {
    case nameCell, genderCell
}

enum LoginCellType {
    case loginCell,userTypeCell
}

enum SignupCellSubType {
    case name , email, password, gender, birthday, address
}

enum ValidityState {
    case valid, invalid, none
}

enum UserType: String {
    case brand = "1"
    case buyer = "2"
    case bussiness = "3"
}

enum Filetype {
    case image
    case video
}

enum BrandDetailCellType {
    case socialProfile
    case education
    case specialization
    case experience
    case certification
    case achievements
}

enum SocialProfileCellType {
    case instagram
    case facebook
    case linkedin
    case twitter
}

enum APIStatusCode: Int {
    case successCodeCreation = 201
    case successCode = 200
}

enum GoogleAPiKey:String {
    case key = "AIzaSyDhLZNxjN8Ob6elOAiHuLEd6XUIqiMnRIo"
}

enum CommonString: String {
    case noInternetDescription = "Your internet connection appears to be offline."
    case termsCondition = "By clicking on sign up you agree to Pipsly’s Terms of Services and Privacy Policy."
    case error = "Error"
    case appName = "Pipsly"
    case parseError = "Unable to parse data."
}

enum TableViewCellIdentifier:String{
    case kBYBBrandsServiceTableViewCell = "BYBBrandsServiceTableViewCell"
    case kBYBAddExperienceTableViewCell = "AddExperienceCell"
}

enum APIMethod{
    static let kGET = "GET"
    static let kPOST = "POST"
    static let kDELETE = "DELETE"
}

// search Related to brand Business
enum BrandBusinessSearch:String{
    case kSearchBrand = "brand"
    case kSearchBusiness = "business"
}
