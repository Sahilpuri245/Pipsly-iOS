//
//  BYBSignupVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 21/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
typealias isFromSignup = (Bool)->(Void)
class BYBSignupVC: BaseVC,GooglePlaceManagerDelegate,BYBSignupService {
    
    @IBOutlet weak var btnSignup: UIButton?
    @IBOutlet weak var lblTermsConditions: UILabel?
    @IBOutlet weak var tblView: UITableView?
    @IBOutlet weak var tblFooterView: UIView!
    var userType:UserType = .buyer
    var dataSource:[SignupCellModel]!
    var signupObj = SignupModel()
    var comlpetionBlock:isFromSignup?
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = SignupCellModel.createDataSourceForSignp(userType: userType)
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: Private methods
    private func setupView(){
        signupObj.user_type = userType.rawValue
        self.btnSignup?.setTitleColor(UIColor.colorWithRGBA(redValue: 255, greenValue: 255, blueValue: 255, alpha: 0.6), for: .normal)
        self.btnSignup?.isUserInteractionEnabled = false
        setAtrributedTermsCondition()
        self.btnSignup?.addGradientLayer([kLightGreenColor, kDarkGreenColor], withDirection: .horizontal)
        self.tblView?.register(SignupNameCell.self)
        self.tblView?.register(SignupGenderCell.self)
        self.tblView?.tableFooterView = tblFooterView
        self.tblView?.reloadData()
    }
    
    private func setAtrributedTermsCondition() {
        let attributedString = NSMutableAttributedString(string: CommonString.termsCondition.rawValue)
        attributedString.addAttributes([
            .font: UIFont(name: "Metropolis-Bold", size: 12.0)!,
            .foregroundColor: kBorderGreenColor
            ], range: NSRange(location: 45, length: 17))
        attributedString.addAttributes([
            .font: UIFont(name: "Metropolis-Bold", size: 12.0)!,
            .foregroundColor: kBorderGreenColor
            ], range: NSRange(location: 67, length: 15))
        lblTermsConditions?.attributedText = attributedString
    }
    
    private func updateStateWithError( cellSubType: SignupCellSubType, state: ValidityState = .none ,error:String = "") {
        for (index, item) in dataSource.enumerated() {
            if cellSubType == item.cellSubtype {
                dataSource[index].state = state
                if state == .invalid {
                    dataSource[index].errorMSg = error
                }
                break
            }
        }
    }
    
    func updateDataSource(cellSubType: SignupCellSubType, inputValue: String ) {
        for (index, item) in dataSource.enumerated() {
            if cellSubType == item.cellSubtype {
                dataSource[index].value = inputValue
                break
            }
        }
        checkSignupStatus()
    }
    
    func checkSignupStatus()  {
        var isSignupCompleted = true
        for (_, item) in dataSource.enumerated() {
            if item.cellSubtype != .birthday {
                if item.value != nil && (item.value?.isEmpty)! {
                    isSignupCompleted = false
                    break
                }
            }
        }
        self.btnSignup?.setTitleColor(UIColor.colorWithRGBA(redValue: 255, greenValue: 255, blueValue: 255, alpha: isSignupCompleted ? 1.0 : 0.6), for: .normal)
        self.btnSignup?.isUserInteractionEnabled = isSignupCompleted ? true : false
    }
    
    func validateData() -> Bool {
        var isDataValidated = true
        if let email = signupObj.email?.trimmingCharacters(in: .whitespaces) {
            if !email.isValidEmail() {
                self.updateStateWithError(cellSubType: .email, state: .invalid, error: kInvalidEmail)
                isDataValidated = false
            } else {
                self.updateStateWithError(cellSubType: .email, state: .valid)
            }
        }
        
        if let password = signupObj.password?.trimmingCharacters(in: .whitespaces) {
            if password.count < kminPasswordLimit || !Utility.checkTextSufficientComplexity(text: password){
                isDataValidated = false
                self.updateStateWithError(cellSubType: .password, state: .invalid, error: kInvalidPassword)
            } else {
                self.updateStateWithError(cellSubType: .password, state: .valid)
            }
        }
        self.tblView?.reloadData()
        return isDataValidated
    }
    
    //MARK: IBAction methods
    @IBAction func tapBack(_ sender: UIButton) {
        comlpetionBlock?(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapSignUp(_ sender: UIButton) {
        let isDataValidated = validateData()
        if isDataValidated {
            if (Reachability.init()?.isReachable)! {
                Utility.showLoader()
                self.signUp(self.signupObj, completion: { (isSuccess,msg,user,error) -> Void in
                    Utility.dismissLoader()
                    if isSuccess {
                        let emailVC = BYBVerifyEmailVC.instantiateWithStoryboard(fromAppStoryboard: .login)
                            self.comlpetionBlock!(false)
                            emailVC.strEmail = self.signupObj.email
                        self.navigationController?.pushViewController(emailVC, animated: true)
                    } else {
                        self.showAlertViewController(viewController: self, withAlertTitle: kAppName, withAlertMessage: msg)
                    }
                })
            } else {
                self.showAlertOnWindow()
            }
        }
    }
    
    //MARK: Googleplace manager delegates
    func didRecieveAddress(address: String?, lat: Double?, lon: Double?) {
        guard let address = address,
              let lat = lat,
              let lon = lon else { return }
        updateDataSource(cellSubType: .address, inputValue: address)
        signupObj.address?.name = address
        signupObj.address?.latitude = lat
        signupObj.address?.longitude = lon
        
        let indexpath = IndexPath(row: 5, section: 0)
        self.tblView?.reloadRows(at: [indexpath], with: .none)
    }
    
    func didFailToReciveAddress(error: Error?) {
        guard let error = error else { return  }
        NSLog("An error occurred while picking a place: \(error)")
    }
    
}
