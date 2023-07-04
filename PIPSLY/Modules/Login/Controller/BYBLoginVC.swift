//
//  BYBLoginVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 29/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

class BYBLoginVC: BaseVC,BYBLoginService,UserTypeCellDelegate,LoginCellDelegate {
   
    @IBOutlet weak var collectionView: UICollectionView?
    var dataSource:[LoginCellModel]!
    var isFromSignup:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = LoginCellModel.createDataSourceForLogin()
        self.collectionView?.register(LoginCell.self)
        self.collectionView?.register(UserTypeCell.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isFromSignup {
            collectionView?.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: false)
            guard let cell = collectionView?.cellForItem(at: IndexPath(item: 1, section: 0)) as? UserTypeCell else { return  }
            cell.updateAttributes()
        }
    }
    
    func didSelectUserType(type: UserType?) {
        guard let userype = type else { return }
        if userype == .brand || userype == .bussiness {
            Utility.showToastMessage(kUnderDevelopment)
            return
        }
        let signupVC = BYBSignupVC.instantiateWithStoryboard(fromAppStoryboard: .login)
        signupVC.userType = userype
        signupVC.comlpetionBlock = {(isSuccess) in
            self.isFromSignup = isSuccess
        }
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    func didSelectBackButton() {
        collectionView?.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
        delay(delay: 0.2) {
            guard let cell = self.collectionView?.cellForItem(at: IndexPath(item: 1, section: 0)) as? UserTypeCell else { return  }
            cell.updateAttributes()
        }
    }
    
    func didSelectSignUp() {
//        let searchBrandResultVC = BYBAddEducationPopupVC.instantiateWithStoryboard(fromAppStoryboard: .userProfile)
//        self.present(searchBrandResultVC, animated: true, completion: nil)
        
        
        let forgotPassVC = BYBAddExperienceVC.instantiateWithStoryboard(fromAppStoryboard: .userProfile)
        self.present(forgotPassVC, animated: true, completion: nil)
        
//        (collectionView?.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: true))!
//        guard let cell = collectionView?.cellForItem(at: IndexPath(item: 0, section: 0)) as? LoginCell else { return  }
//        cell.resetCell()
    }
    
    func didTapForgotPassword() {
        let forgotPassVC = BYBForgotPasswordVC.instantiateWithStoryboard(fromAppStoryboard: .login)
        
        self.present(forgotPassVC, animated: true, completion: nil)
    }
    
    //MARK: API CALL
    func didSelectSignIn(model: LoginModel?) {
        guard let model = model else { return }
        if (Reachability.init()?.isReachable)! {
            Utility.showLoader()
            self.login(model, completion: { (isSuccess,msg,user,error) -> Void in
                Utility.dismissLoader()
                if isSuccess {
                    self.navigateUserOnboardingWithType(type: user?.userType)
                } else {
                    self.showAlertViewController(viewController: self, withAlertTitle: kAppName, withAlertMessage: msg)
                }
            })
        } else {
            self.showAlertOnWindow()
        }
    }
    
    func navigateUserOnboardingWithType(type:String?){
        if type == UserType.buyer.rawValue {
            let areaInterestVC = BYBAreaInterestVC.instantiateWithStoryboard(fromAppStoryboard: .login)
            self.navigationController?.pushViewController(areaInterestVC, animated: true)
        } else if type == UserType.brand.rawValue {
            let brandDetailVC = BYBAddBrandDetailsVC.instantiateWithStoryboard(fromAppStoryboard: .login)
            self.navigationController?.pushViewController(brandDetailVC, animated: true)
        }
        
    }
}

