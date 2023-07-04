//
//  BYBForgotPasswordVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 03/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
let kHeightX:CGFloat = 279.0
let kHeightDefault:CGFloat = 245.0

class BYBForgotPasswordVC: BaseVC,BYBLoginService {

    @IBOutlet weak var btnSendLink: UIButton?
    @IBOutlet weak var viewPassword: UIView?
    @IBOutlet weak var txtEmail: UITextField?
    @IBOutlet weak var lblError: UILabel?
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint?
    @IBOutlet weak var heightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: Double(0.2), animations: {
            self.bottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != viewPassword {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: private methods
    private func setupView()  {
        self.btnSendLink?.setTitleColor(UIColor.colorWithRGBA(redValue: 255, greenValue: 255, blueValue: 255, alpha: 0.6), for: .normal)
        self.btnSendLink?.isUserInteractionEnabled = false
        self.heightConstraint?.constant = DeviceType.IS_IPHONE_X ? kHeightX : kHeightDefault
    }
    
    private func validateData() -> Bool {
        var isDataValid = true
        if let email = txtEmail?.text?.trimmingCharacters(in: .whitespaces) {
            if !email.isValidEmail() {
                isDataValid = false
                self.lblError?.text = kInvalidEmail
                self.lblError?.backgroundColor = kRedColor
                self.txtEmail?.layer.borderColor = kBorderRedColor.cgColor
                self.txtEmail?.layer.borderWidth = 1.0
            } else {
                self.lblError?.text = ""
                self.lblError?.backgroundColor = .clear
                self.txtEmail?.layer.borderColor = UIColor.clear.cgColor
                self.txtEmail?.layer.borderWidth = 1.0
            }
        }
        return isDataValid
    }
    
    @IBAction func tapSendLink(_ sender: UIButton) {
        let isValidData = validateData()
        if isValidData {
            guard let email = txtEmail?.text else { return }
            if (Reachability.init()?.isReachable)! {
                Utility.showLoader()
                self.forgotPassword(email) { (isSuccess, msg, error) in
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
    }
}

extension BYBForgotPasswordVC:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.lblError?.text = ""
        self.lblError?.backgroundColor = .clear
        self.txtEmail?.layer.borderColor = kBorderGreenColor.cgColor
        self.txtEmail?.layer.borderWidth = 1.0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.lblError?.text = ""
        self.lblError?.backgroundColor = .clear
        self.txtEmail?.layer.borderColor = UIColor.clear.cgColor
        self.txtEmail?.layer.borderWidth = 1.0
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " {
            return false
        }
        let textobj = (textField.text ?? "") as NSString
        let resultString = textobj.replacingCharacters(in: range, with: string)
        if resultString.count > 0{
            self.btnSendLink?.isUserInteractionEnabled = true
            self.btnSendLink?.setTitleColor(.white, for: .normal)
        } else {
            self.btnSendLink?.setTitleColor(UIColor.colorWithRGBA(redValue: 255, greenValue: 255, blueValue: 255, alpha: 0.6), for: .normal)
                self.btnSendLink?.isUserInteractionEnabled = false
        }
        return true
    }
}
