//
//  BYBAddEducationVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 11/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//


import UIKit

enum AddEducationPopupMode {
    case Edit
    case View
    case Add
}

class BYBAddEducationPopupVC: BaseVC, BYBAddBrandEducationService, BYBCalenderPickerViewDelegate {
    
    @IBOutlet var bottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var universityTxt: UITextField?
    @IBOutlet var textfieldStack: UIStackView!
    @IBOutlet var addEducationView: UIView!
    @IBOutlet var textfieldViewHeight: NSLayoutConstraint!
    @IBOutlet var addButtonTop: NSLayoutConstraint!
    @IBOutlet weak var errorUniversityLabel: UILabel!
    @IBOutlet weak var fieldOfStudyTxt: UITextField?
    @IBOutlet weak var errorFieldOfUniversityLabel: UILabel!
    @IBOutlet weak var yearPassedTxt: UITextField?
    @IBOutlet weak var errorYearOfPassedLabel: UILabel!
    @IBOutlet weak var yearPassedView: UIView!
    @IBOutlet weak var addEducationButton: UIButton!
    var textfieldHeight : CGFloat = 347.0
    var screenViewMode : AddEducationPopupMode = .Add
    var anyChanges = false
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupUI()
        Utility.setupYearTextfield(textfield : yearPassedTxt)
        setViewMode()
    }
    
    func setViewMode(){
         if screenViewMode == .Edit || screenViewMode == .Add{
            Utility.disableButton(btn: addEducationButton)
            fieldOfStudyTxt?.isUserInteractionEnabled = true
            universityTxt?.isUserInteractionEnabled = true
            yearPassedTxt?.isUserInteractionEnabled = true
        }
        else if screenViewMode == .View {
            Utility.disableButton(btn: addEducationButton)
            fieldOfStudyTxt?.isUserInteractionEnabled = false
            universityTxt?.isUserInteractionEnabled = false
            yearPassedTxt?.isUserInteractionEnabled = false
        }
    }
    
    func setupUI(){
        self.addEducationButton?.addGradientLayer([kLightGreenColor, kDarkGreenColor], withDirection: .horizontal)
        hideErrorPassword()
    }
    
    func hideErrorPassword(){
        self.errorUniversityLabel?.isHidden = true
        self.errorFieldOfUniversityLabel?.isHidden = true
        self.errorYearOfPassedLabel?.isHidden = true
        Utility.disableButton(btn: addEducationButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: Double(0.2), animations: {
            self.bottomConstraints?.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addEducationButtonAction(_ sender: Any) {
//        let brandBusinessSearchVC = BYBBrandAddExperiencePopVC.instantiateWithStoryboard(fromAppStoryboard: .userProfile)
//        self.navigationController?.pushViewController(brandBusinessSearchVC, animated: true)
        self.view.endEditing(true)
        if validateData(){
           // hitAddEductaionApi()
        }
    }
    
    func hitAddEductaionApi(){
        
        
        guard let university = universityTxt?.text else { return }
        guard let  fieldOfStudy =  fieldOfStudyTxt?.text else{ return
        }
        guard let  passedYear =  yearPassedTxt?.text else{ return
        }
        
      let addEducationDict =  [
            "year": passedYear,
            "university": university,
            "study_field": fieldOfStudy,
            "education_type": "1"
        ] as [String : Any]
        if (Reachability.init()?.isReachable)! {
            Utility.showLoader()
            self.addBrandEducation(addEducationObj: addEducationDict, completion:
            { (isSuccess,msg,user,error) -> Void in
                    Utility.dismissLoader()
                    if isSuccess {
                        self.showAlertViewController(viewController: self, withAlertTitle: kAppName, withAlertMessage: msg)
                    } else {
                        self.showAlertViewController(viewController: self, withAlertTitle: kAppName, withAlertMessage: msg)
                    }
                })
            } else {
                self.showAlertOnWindow()
            }
        }

    //MARK: private methods
    private func validateData() -> Bool {
        var isDataValid = true
        
        if let univeristy = universityTxt?.text?.trimmingCharacters(in: .whitespaces) {
            if (univeristy.count > kMaxCharacterLimit || univeristy.isEmpty){
                isDataValid = false
                self.errorUniversityLabel?.text = kInvalidUniversity
                self.errorUniversityLabel?.isHidden = false
                self.universityTxt?.addTextFieldBorderColorWidth(borderColor:kBorderRedColor,borderWidth:1.0)
            } else{
                self.errorUniversityLabel?.text = ""
                self.errorUniversityLabel?.isHidden = true
                self.universityTxt?.addTextFieldBorderColorWidth(borderColor:.clear,borderWidth:1.0)
            }
        }
        
        if let fieldOfStudy = fieldOfStudyTxt?.text?.trimmingCharacters(in: .whitespaces) {
               if (fieldOfStudy.count > kMaxCharacterLimit || fieldOfStudy.isEmpty) {
                isDataValid = false
                self.errorFieldOfUniversityLabel?.text = kInvalidFieldOfStudy
                self.errorFieldOfUniversityLabel?.isHidden = false
                self.fieldOfStudyTxt?.addTextFieldBorderColorWidth(borderColor:kBorderRedColor,borderWidth:1.0)
            } else {
                self.errorFieldOfUniversityLabel?.text = ""
                self.errorFieldOfUniversityLabel?.isHidden = false
                self.fieldOfStudyTxt?.addTextFieldBorderColorWidth(borderColor:.clear,borderWidth:1.0)
            }
        }
        
        if let yearPassed = yearPassedTxt?.text?.trimmingCharacters(in: .whitespaces) {
            if (yearPassed.count > kMaxCharacterLimit || yearPassed.isEmpty) {
                isDataValid = false
                self.errorYearOfPassedLabel?.text = kInvalidYearPassed
                self.errorYearOfPassedLabel?.isHidden = false
                self.yearPassedView.addViewBorderColorWidth(borderColor: kBorderRedColor, borderWidth: 1.0)
            } else {
                self.errorYearOfPassedLabel?.text = ""
                self.errorYearOfPassedLabel?.isHidden = false
                self.yearPassedView.addViewBorderColorWidth(borderColor: .clear, borderWidth: 1.0)
            }
        }
        
        return isDataValid
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != addEducationView {
            if anyChanges {
                Utility.showAlertViewControllertMessage(alertTitle:kAppName, alertmessage: kDiscardEducation, okButtonTitle:kMessage_No_Button_Title, calcelButtonTitle: kMessage_Yes_Button_Title, ViewController: self, and: { (result) in
                    if result == false{
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

extension BYBAddEducationPopupVC:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == universityTxt {
            self.errorUniversityLabel?.isHidden = true
            self.universityTxt?.addTextFieldBorderColorWidth(borderColor:kBorderGreenColor,borderWidth:1.0)
        }
        else if textField == fieldOfStudyTxt  {
            self.errorFieldOfUniversityLabel?.isHidden = true
            fieldOfStudyTxt?.addTextFieldBorderColorWidth(borderColor:kBorderGreenColor,borderWidth:1.0)
        }
        else if textField == yearPassedTxt  {
            maintainPickerSpace()
            Utility.addPickerForYearTextfield(frameY: textfieldStack.frame.origin.y + textfieldStack.frame.height, view: addEducationView, viewContDelegate: self, pickerType :.year)
            self.errorYearOfPassedLabel.isHidden = true
            yearPassedView?.addViewBorderColorWidth(borderColor:kBorderGreenColor,borderWidth:1.0)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        anyChanges = true
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == universityTxt {
            universityTxt?.addTextFieldBorderColorWidth(borderColor:.clear,borderWidth:1.0)
        }
        else if textField == fieldOfStudyTxt  {
            fieldOfStudyTxt?.addTextFieldBorderColorWidth(borderColor:.clear,borderWidth:1.0)
        }
        else if textField == yearPassedTxt{
            Utility.removePickerForYearTextfield(viewCont: self)
            removePickerSpace()
            yearPassedView?.addViewBorderColorWidth(borderColor:.clear,borderWidth:1.0)
        }
        checkAddButton()
    }
    
    func checkAddButton(){
        let univeristy = universityTxt?.text?.trimmingCharacters(in: .whitespaces)
        let fieldOfStudy = fieldOfStudyTxt?.text?.trimmingCharacters(in: .whitespaces)
        let yearPassed = yearPassedTxt?.text?.trimmingCharacters(in: .whitespaces)
            
        if (univeristy?.isEmpty)! || (fieldOfStudy?.isEmpty)! || (yearPassed?.isEmpty)! {
            Utility.disableButton(btn: addEducationButton)
        }else{
            Utility.enableButton(btn: addEducationButton)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func maintainPickerSpace(){
        UIView.animate(withDuration: Double(0.2), animations: {
        self.addButtonTop.constant = kYearPickerHeight
        self.textfieldViewHeight.constant  = self.textfieldHeight + kYearPickerHeight
        self.view.layoutIfNeeded()
        })
    }
    
    func removePickerSpace(){
          UIView.animate(withDuration: Double(0.2), animations: {
            self.addButtonTop.constant = 15.0
            self.textfieldViewHeight.constant  = self.textfieldHeight
            self.view.layoutIfNeeded()
          })
        self.view.endEditing(true)
    }
    
    //MARK: CallBack Delegate for year Picker
    func setSelectedValue(year : String) {
        Utility.removePickerForYearTextfield(viewCont: self)
        removePickerSpace()
        yearPassedTxt?.text = year
        checkAddButton()
    }
}
