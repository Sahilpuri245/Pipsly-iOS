//
//  AddBrandDetailModel.swift
//  PIPSLY
//
//  Created by KiwiTech on 13/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation
import UIKit


class SocialProfileModel {
    var name:String!
    var isSwitchOn:Bool!
    var image:UIImage!
    var cellType:SocialProfileCellType?
    
    class func createDataSourceForSocialProfilecell() -> [SocialProfileModel]   {
        var arrayProfiles = [SocialProfileModel]()
        
        let instaModel = SocialProfileModel()
        instaModel.name = "Instagram"
        instaModel.isSwitchOn = false
        instaModel.image = #imageLiteral(resourceName: "iconInsta")
        arrayProfiles.append(instaModel)
        
        let facebookModel = SocialProfileModel()
        facebookModel.name = "Facebook"
        facebookModel.isSwitchOn = false
        facebookModel.image = #imageLiteral(resourceName: "iconFb")
        arrayProfiles.append(facebookModel)
        
        let linkedinModel = SocialProfileModel()
        linkedinModel.name = "Linkedin"
        linkedinModel.isSwitchOn = false
        linkedinModel.image = #imageLiteral(resourceName: "iconLinkedin")
        arrayProfiles.append(linkedinModel)
        
        let twitterModel = SocialProfileModel()
        twitterModel.name = "Twitter"
        twitterModel.isSwitchOn = false
        twitterModel.image = #imageLiteral(resourceName: "iconTwitter")
        arrayProfiles.append(twitterModel)
        
        return arrayProfiles
    }
}

class EducationModel {
    var year:String?
    var title:String?
    var universityName:String?
}

class SpecializationModel {
    var specialization:String?
    var categories:[String]?
}

class ExperienceModel {
    var yearsActive:String?
    var title:String?
    var companyName:String?
    var address:String?
}

class CertificationModel {
    var year:String?
    var skillTitle:String?
    var universityName:String?
}

class AchievementModel {
    var type:Filetype?
}

class AddBrandDetailModel {
    var sectionTitle:String?
    var headerMsg:String?
    var footerMsg:String?
    var cellType:BrandDetailCellType?
    var dataSource:[Any]?
    
    func createDataSourceForAddBrandDetails() -> [AddBrandDetailModel] {
        var arrBrandDetail = [AddBrandDetailModel]()
        
        let socialProfileDataModel = AddBrandDetailModel()
        socialProfileDataModel.sectionTitle = "SOCIAL PROFILES"
        socialProfileDataModel.headerMsg = "This will help you brand your profile. No data from Pipsly would be posted on these platforms."
        socialProfileDataModel.footerMsg = "Would you like to mention your specialization and achievements, So the buyers who are looking for your service can easily find you."
        socialProfileDataModel.cellType = BrandDetailCellType.socialProfile
        socialProfileDataModel.dataSource = SocialProfileModel.createDataSourceForSocialProfilecell()
        arrBrandDetail.append(socialProfileDataModel)
        
        let addEducationDataModel = AddBrandDetailModel()
        addEducationDataModel.cellType = BrandDetailCellType.education
        addEducationDataModel.dataSource = [EducationModel]()
        arrBrandDetail.append(addEducationDataModel)
        
        let addSpecializationDataModel = AddBrandDetailModel()
        addSpecializationDataModel.cellType = BrandDetailCellType.specialization
        addSpecializationDataModel.dataSource = [SpecializationModel]()
        arrBrandDetail.append(addSpecializationDataModel)
        
        let addExperienceDataModel = AddBrandDetailModel()
        addExperienceDataModel.cellType = BrandDetailCellType.experience
        addExperienceDataModel.dataSource = [ExperienceModel]()
        arrBrandDetail.append(addExperienceDataModel)
        
        let addCertificationDataModel = AddBrandDetailModel()
        addCertificationDataModel.cellType = BrandDetailCellType.certification
        addCertificationDataModel.dataSource = [CertificationModel]()
        arrBrandDetail.append(addCertificationDataModel)
        
        let addAchievementDataModel = AddBrandDetailModel()
        addAchievementDataModel.cellType = BrandDetailCellType.achievements
        addAchievementDataModel.dataSource = [AchievementModel]()
        arrBrandDetail.append(addAchievementDataModel)
        
        return arrBrandDetail
    }
    
}
