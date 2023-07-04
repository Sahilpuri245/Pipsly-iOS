//
//  BYBChangePasswordVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 04/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
class  BYBChangePasswordVC: BaseVC,BYBChangePasswordService{
    
    @IBOutlet weak var viewChangePassword: UIView!
    @IBOutlet weak var btnShow: UIButton?
    @IBOutlet weak var btnChangePassword: UIButton?
    @IBOutlet weak var txtCurrentPassword: UITextField?
    @IBOutlet weak var txtNewPassword: UITextField?
    @IBOutlet weak var viewCurrentPassword: UIView?
    @IBOutlet weak var viewNewPassword: UIView?
    @IBOutlet weak var lblCurrentPasswordError: UILabel?
    @IBOutlet weak var lblNewPasswordError: UILabel?

    var isButtonHide = true
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        self.btnChangePassword?.addGradientLayer([kLightGreenColor, kDarkGreenColor], withDirection: .horizontal)
        hideErrorPassword()
    }
    func hideErrorPassword(){
         self.lblCurrentPasswordError?.isHidden = true
         self.lblNewPasswordError?.isHidden = true
        buttonEnableDisableInteraction(btnChangePasswordEnable:false,btnShowEnable:false)
        btnChangePassword?.setTitleColor(kGrayColor, for: .normal)
        
    }
   
    //MARK: private methods
    private func validateData() -> Bool {
        var isDataValid = true
       
        if let currentPassword = txtCurrentPassword?.text?.trimmingCharacters(in: .whitespaces) {
            if currentPassword.count < kminPasswordLimit  || !Utility.checkTextSufficientComplexity(text: currentPassword){
                isDataValid = false
                self.lblCurrentPasswordError?.text = kInvalidPassword
                self.lblCurrentPasswordError?.isHidden = false
      self.viewCurrentPassword?.addViewBorderColorWidth(borderColor:kBorderRedColor,borderWidth:1.0)
            } else{
                self.lblCurrentPasswordError?.text = ""
                self.lblCurrentPasswordError?.isHidden = true
               
        self.viewCurrentPassword?.addViewBorderColorWidth(borderColor:.clear,borderWidth:1.0)
            }
        }
        
        if let newPassword = txtNewPassword?.text?.trimmingCharacters(in: .whitespaces) {
            if newPassword.count < kminPasswordLimit  || !Utility.checkTextSufficientComplexity(text: newPassword){
                isDataValid = false
                self.lblNewPasswordError?.text = kInvalidPassword
                self.lblNewPasswordError?.isHidden = false
            self.viewNewPassword?.addViewBorderColorWidth(borderColor:kBorderRedColor,borderWidth:1.0)
            } else{
                self.lblNewPasswordError?.text = ""
                self.lblNewPasswordError?.isHidden = true
           self.viewNewPassword?.addViewBorderColorWidth(borderColor:.clear,borderWidth:1.0)
            }
        }
        return isDataValid
    }
 
    // to enable disable user InteractionEanble Button
    func buttonEnableDisableInteraction(btnChangePasswordEnable:Bool,btnShowEnable:Bool){
        btnChangePassword?.isUserInteractionEnabled = btnChangePasswordEnable
        btnShow?.isUserInteractionEnabled = btnShowEnable
    }
    
    
    
    @IBAction func btnActionChangePassword(_ sender: Any) {
        let isDataValid = validateData()
        if isDataValid {
            self.lblCurrentPasswordError?.isHidden = true
            self.lblNewPasswordError?.isHidden = true
            
            self.hitApiForChangePassword()
        }
        
    }
    
    // to change password Api
    func hitApiForChangePassword(){
        guard let currentPassword = txtCurrentPassword?.text else { return }
        guard let  newPassword = txtNewPassword?.text else{ return
        }
        if (Reachability.init()?.isReachable)!{
            Utility.showLoader()
            self.changePassword(currentPassword, newPassword){ (isSuccess, msg, error) in
                Utility.dismissLoader()
                if isSuccess {
                    self.showAlertViewOnViewController(viewController: self, showAlerTitle: kAppName, showAlerMessage: msg, withOptionsButton: [kOkBtn], callBack: { (_, index) in
                        if index == 0 {
                            self.pushToUpdateEmailScreen()
                           
                        }
                    })
                } else {
                    self.showAlertViewController(viewController: self, withAlertTitle: kAppName, withAlertMessage: msg)
                   
                }
            }
        }
    }
    
    func pushToUpdateEmailScreen(){

    }
    
    @IBAction func btnActionShowHide(_ sender: Any) {
        
        if(isButtonHide == true) {
            txtNewPassword?.isSecureTextEntry = false
            btnShow?.setTitle(kHide, for: .normal)
        } else {
            txtNewPassword?.isSecureTextEntry = true
             btnShow?.setTitle(kShow, for: .normal)
        }
        
        isButtonHide = !isButtonHide
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != viewChangePassword {
            self.dismiss(animated: true, completion: nil)
        }
    }
}


extension BYBChangePasswordVC:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtCurrentPassword {
        buttonEnableDisableInteraction(btnChangePasswordEnable:true,btnShowEnable:false)
            
            self.lblCurrentPasswordError?.text = ""
            self.lblCurrentPasswordError?.isHidden = true
      self.viewCurrentPassword?.addViewBorderColorWidth(borderColor:kBorderGreenColor,borderWidth:1.0)
        } else if textField == txtNewPassword  {
             buttonEnableDisableInteraction(btnChangePasswordEnable:true,btnShowEnable:true)
            
            self.lblNewPasswordError?.text = ""
            self.lblNewPasswordError?.isHidden = true
        self.viewNewPassword?.addViewBorderColorWidth(borderColor:kBorderGreenColor,borderWidth:1.0)
        }
        btnChangePassword?.setTitleColor(.white, for: .normal)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtCurrentPassword {
     self.viewCurrentPassword?.addViewBorderColorWidth(borderColor:.clear,borderWidth:1.0)
        } else if textField == txtNewPassword  {
     self.viewNewPassword?.addViewBorderColorWidth(borderColor:.clear,borderWidth:1.0)
      buttonEnableDisableInteraction(btnChangePasswordEnable:true,btnShowEnable:true)
        }
    }
}
