//
//  BYBVerifyEmailVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 28/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
let str1 = "A verification email has been sent to "
let str2 = " Please verify your email to continue. "

class BYBVerifyEmailVC: BaseVC,BYBSignupService {

    var strEmail:String?
    @IBOutlet weak var lblMsg: UILabel?
    @IBOutlet weak var btnSignIn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view?.addGradientLayer([kLightGreenColor, kDarkGreenColor], withDirection: .vertical)
        self.btnSignIn?.backgroundColor = UIColor.colorWithRGBA(redValue: 26, greenValue: 22, blueValue: 22, alpha: 0.29)
        if let email = strEmail {
            let verifyEmailMsg = str1 + email + "."+str2
            if let range = Utility.getRange(string: verifyEmailMsg, substring: email) {
                let attrString = Utility.getAttributtedString(str: verifyEmailMsg, range: range, font: UIFont(name: "Metropolis-SemiBold", size: 14)!, color: .white)
                self.lblMsg?.attributedText = attrString
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapNavigateToSignIn(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func tapResendEmail(_ sender: UIButton) {
        guard let email = strEmail else {
            return
        }
        if (Reachability.init()?.isReachable)! {
             Utility.showLoader()
            self.verifyEmail(email, completion: { (isSuccess,msg,error) -> Void in
                Utility.dismissLoader()
                if isSuccess {
                    self.showAlertViewController(viewController: self, withAlertTitle: kAppName, withAlertMessage: msg)
                } else {
                    self.showAlertViewController(viewController: self, withAlertTitle: kAppName, withAlertMessage: msg)
                }
            })
        }else {

        }
    }
    
}
