//
//  BYBUpdateEmailVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 05/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
class  BYBUpdateEmailVC: BaseVC,BYBChangePasswordService{
    
    @IBOutlet weak var viewUpdateEmail: UIView!
    @IBOutlet weak var btnUpdateEmail: UIButton?
    @IBOutlet weak var txtCurrentPassword: UITextField?
    @IBOutlet weak var txtNewEmail: UITextField?
    @IBOutlet weak var viewCurrentPassword: UIView?
    @IBOutlet weak var viewNewEmail: UIView?
    @IBOutlet weak var lblCurrentPasswordError: UILabel?
    @IBOutlet weak var lblNewEmailError: UILabel?
    override func viewDidLoad(){
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        self.btnUpdateEmail?.addGradientLayer([kLightGreenColor, kDarkGreenColor], withDirection: .horizontal)
        hideErrorPassword()
    }
    
    func hideErrorPassword(){
        self.lblCurrentPasswordError?.isHidden = true
        self.lblNewEmailError?.isHidden = true
        btnUpdateEmail?.isUserInteractionEnabled = false
        btnUpdateEmail?.setTitleColor(kGrayColor, for: .normal)
        
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
        
        if let newEmail = txtNewEmail?.text?.trimmingCharacters(in: .whitespaces) {
            if !newEmail.isValidEmail() {
                isDataValid = false
                self.lblNewEmailError?.text = kIncorrectEmail
                 self.lblNewEmailError?.isHidden = false
                 self.viewNewEmail?.addViewBorderColorWidth(borderColor:kBorderRedColor,borderWidth:1.0)
            } else {
                self.lblNewEmailError?.text = ""
                self.lblNewEmailError?.isHidden = false
                self.viewNewEmail?.addViewBorderColorWidth(borderColor:.clear,borderWidth:1.0)
            }
        }
        return isDataValid
    }
    
    
    @IBAction func btnActionUpdateEmail(_ sender: Any) {
        let isDataValid = validateData()
        if isDataValid {
            self.lblCurrentPasswordError?.isHidden = true
            self.lblNewEmailError?.isHidden = true
            self.hitUpdateEmailApi()
        }
    }
    
    func hitUpdateEmailApi(){
        
        guard let currentPassword = txtCurrentPassword?.text else { return }
        guard let  newEmail =  txtNewEmail?.text else{ return
        }
        if (Reachability.init()?.isReachable)! {
            Utility.showLoader()
            self.updateEmail(newEmail, currentPassword){ (isSuccess, msg, error) in
                Utility.dismissLoader()
                if isSuccess {
                    self.showAlertViewOnViewController(viewController: self, showAlerTitle: kAppName, showAlerMessage: msg, withOptionsButton: [kOkBtn], callBack: { (_, index) in
                        if index == 0 {
                            self.dismiss(animated: true, completion: nil)
                        }
                    })
                } else {
                    self.showAlertViewController(viewController: self, withAlertTitle: kAppName, withAlertMessage: msg)
                }
            }
        }
    }
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != viewUpdateEmail {
            self.dismiss(animated: true, completion: nil)
        }
    }
}


extension BYBUpdateEmailVC:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtCurrentPassword {
            btnUpdateEmail?.isUserInteractionEnabled = false
            self.lblCurrentPasswordError?.text = ""
            self.lblCurrentPasswordError?.isHidden = true
            self.viewCurrentPassword?.addViewBorderColorWidth(borderColor:kBorderGreenColor,borderWidth:1.0)
            
        } else if textField == txtNewEmail  {
            btnUpdateEmail?.isUserInteractionEnabled = true
            self.lblNewEmailError?.text = ""
            self.lblNewEmailError?.isHidden = true
            self.viewNewEmail?.addViewBorderColorWidth(borderColor:kBorderGreenColor,borderWidth:1.0)
        }
        btnUpdateEmail?.setTitleColor(.white, for: .normal)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtCurrentPassword {
    
            self.viewCurrentPassword?.addViewBorderColorWidth(borderColor:.clear,borderWidth:1.0)
        } else if textField == txtNewEmail  {
            self.viewNewEmail?.addViewBorderColorWidth(borderColor:.clear,borderWidth:1.0)

            btnUpdateEmail?.isUserInteractionEnabled = true
            
        }
    }
}
