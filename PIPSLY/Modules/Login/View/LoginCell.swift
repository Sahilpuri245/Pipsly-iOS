//
//  LoginCell.swift
//  PIPSLY
//
//  Created by KiwiTech on 29/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
protocol LoginCellDelegate:class {
    func didTapForgotPassword()
    func didSelectSignUp()
    func didSelectSignIn(model:LoginModel?)
}

class LoginModel {
    var email:String?
    var password:String?
    
    init() {
    }
}

class LoginCell: BaseCollectionCell {
    
    @IBOutlet weak var txtEmail: UITextField?
    @IBOutlet weak var txtPassword: UITextField?
    @IBOutlet weak var lblEmailError: UILabel?
    @IBOutlet weak var lblPasswordError: UILabel?
    weak var delegate:LoginCellDelegate?
    var loginModel:LoginModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loginModel = LoginModel()
        addForgotPassButton()
    }
    
    //MARK: private methods
    private func validateData() -> Bool {
        var isDataValid = true
        guard let model = loginModel else { return false }
        if let email = model.email?.trimmingCharacters(in: .whitespaces) {
            if !email.isValidEmail() {
                isDataValid = false
                self.lblEmailError?.text = kInvalidEmail
                self.lblEmailError?.backgroundColor = kRedColor
                self.txtEmail?.layer.borderColor = kBorderRedColor.cgColor
                self.txtEmail?.layer.borderWidth = 1.0
            } else {
                self.lblEmailError?.text = ""
                self.lblEmailError?.backgroundColor = .clear
                self.txtEmail?.layer.borderColor = UIColor.clear.cgColor
                self.txtEmail?.layer.borderWidth = 1.0
            }
        } else {
            isDataValid = false
            self.lblEmailError?.text = kInvalidEmail
            self.lblEmailError?.backgroundColor = kRedColor
            self.txtEmail?.layer.borderColor = kBorderRedColor.cgColor
            self.txtEmail?.layer.borderWidth = 1.0
        }
        if let password = model.password?.trimmingCharacters(in: .whitespaces) {
            if password.count < kminPasswordLimit || !Utility.checkTextSufficientComplexity(text: password) {
                isDataValid = false
                self.lblPasswordError?.backgroundColor = kRedColor
                self.lblPasswordError?.text = kInvalidPassword
                self.txtPassword?.layer.borderColor = kBorderRedColor.cgColor
                self.txtPassword?.layer.borderWidth = 1.0
            } else{
                self.lblPasswordError?.text = ""
                self.lblPasswordError?.backgroundColor = .clear
                self.txtPassword?.layer.borderColor = UIColor.clear.cgColor
                self.txtPassword?.layer.borderWidth = 1.0
            }
        } else {
            isDataValid = false
            self.lblPasswordError?.backgroundColor = kRedColor
            self.lblPasswordError?.text = kInvalidPassword
            self.txtPassword?.layer.borderColor = kBorderRedColor.cgColor
            self.txtPassword?.layer.borderWidth = 1.0
        }
        return isDataValid
    }
    
    private func addForgotPassButton() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "iconForgotQuestion"), for: .normal)
        button.frame = CGRect(x: CGFloat((txtPassword?.frame.size.width)! - 50), y: CGFloat(1), width: CGFloat(48), height: CGFloat(48))
        button.addTarget(self, action: #selector(self.tapForgotPassword), for: .touchUpInside)
        txtPassword?.rightView = button
        txtPassword?.rightViewMode = .always
    }
    
    @objc func tapForgotPassword()  {
        delegate?.didTapForgotPassword()
    }
    
    //MARK: Public method
    func resetCell() {
        self.txtEmail?.text = ""
        self.txtPassword?.text = ""
        self.txtEmail?.layer.borderColor = UIColor.clear.cgColor
        self.txtEmail?.layer.borderWidth = 1.0
        self.txtPassword?.layer.borderColor = UIColor.clear.cgColor
        self.txtPassword?.layer.borderWidth = 1.0
        self.lblEmailError?.text = ""
        self.lblPasswordError?.text = ""
        self.lblEmailError?.backgroundColor = .clear
        self.lblPasswordError?.backgroundColor = .clear

    }
    
    //MARK: IBAction methods
    @IBAction func tapSignIn(_ sender: UIButton) {
        let isDataValid = validateData()
        if isDataValid {
            guard let model = loginModel else {return}
            delegate?.didSelectSignIn(model: model)
        }
    }
    
    @IBAction func tapSignUp(_ sender: UIButton) {
        delegate?.didSelectSignUp()
    }
}

extension LoginCell : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtEmail {
            self.lblEmailError?.text = ""
            self.lblEmailError?.backgroundColor = .clear
            self.txtEmail?.layer.borderColor = kBorderGreenColor.cgColor
            self.txtEmail?.layer.borderWidth = 1.0
        } else if textField == txtPassword  {
            self.lblPasswordError?.text = ""
            self.lblPasswordError?.backgroundColor = .clear
            self.txtPassword?.layer.borderColor = kBorderGreenColor.cgColor
            self.txtPassword?.layer.borderWidth = 1.0
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " {
            return false
        }
        let textobj = (textField.text ?? "") as NSString
        let resultString = textobj.replacingCharacters(in: range, with: string)
        
        if textField == txtEmail {
            loginModel?.email = resultString
        } else {
            loginModel?.password = resultString
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtEmail {
            self.txtEmail?.layer.borderColor = UIColor.clear.cgColor
            self.txtEmail?.layer.borderWidth = 1.0
        } else if textField == txtPassword  {
            self.txtPassword?.layer.borderColor = UIColor.clear.cgColor
            self.txtPassword?.layer.borderWidth = 1.0
        }
    }
}
