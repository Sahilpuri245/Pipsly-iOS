//
//  BYBBrandAddExperience.swift
//  PIPSLY
//
//  Created by KiwiTech on 12/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
class BYBBrandAddExperiencePopVC: BaseVC,BYBAddBrandEducationService {
    var myPickerView : UIPickerView?
    var pickerData = [String]()
    @IBOutlet weak var designationTxt: UITextField?
    @IBOutlet weak var errorDesignationLabel: UILabel?
    @IBOutlet weak var businessTxt: UITextField?
    @IBOutlet weak var errorBusinessLabel: UILabel?
    @IBOutlet weak var locationTxt: UITextField?
    @IBOutlet weak var errorLocationLabel: UILabel?
    @IBOutlet weak var startYearView: UIView?
    @IBOutlet weak var startYearTxt: UITextField?
    @IBOutlet weak var errorStartYearLabel:UILabel?
    @IBOutlet weak var endYearView: UIView?
    @IBOutlet weak var endYearTxt: UITextField?
    @IBOutlet weak var errorEndYearLabel:UILabel?
    @IBOutlet weak var addExperienceButton: UIButton?
    let dateFormatter = DateFormatter()
    let today = Date()
    let currentCalendar = Calendar.current
    var selectedTxt = Int()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        self.addExperienceButton?.addGradientLayer([kLightGreenColor, kDarkGreenColor], withDirection: .horizontal)
        last15year()
        hideErrorPassword()
    }
    
    func hideErrorPassword(){
        self.errorDesignationLabel?.isHidden = true
        self.errorBusinessLabel?.isHidden = true
        self.errorLocationLabel?.isHidden = true
        self.errorStartYearLabel?.isHidden = true
        self.errorEndYearLabel?.isHidden = true
        addExperienceButton?.isUserInteractionEnabled = false
        addExperienceButton?.setTitleColor(kGrayColor, for: .normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func last15year(){
        let year = Calendar.current.component(.year, from: Date())
        let currentYear =  Int(year)
        let minyear = kMinYear
        for currentdata in minyear..<(currentYear+1) {
            pickerData.append(String(currentdata))
            pickerData.reverse()
        }
    }
    
    
    @IBAction func addEducationButtonAction(_ sender: Any) {
        let isDataValid = validateData()
        if isDataValid {
            self.errorDesignationLabel?.isHidden = true
            self.errorBusinessLabel?.isHidden = true
            self.errorLocationLabel?.isHidden = true
            self.errorStartYearLabel?.isHidden = true
            self.errorEndYearLabel?.isHidden = true
            self.hitAddExperienceApi()
        }
    }
    
    func dateCompareStartEndDate(){
        guard let startDate = self.startYearTxt?.text else{
            return
        }
        guard let endDate = self.endYearTxt?.text else{
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let firstDate = formatter.date(from: startDate )
        let secondDate = formatter.date(from: endDate)
        let result = firstDate?.compare(secondDate ?? Date())
        switch result {
        case .orderedAscending?     :   print("firstDate is earlier than second date")
        case .orderedDescending?    :   print("firstDate is later than second Date")
        case .orderedSame?          :   print("Both dates are the same")
        case .none: break
        }
    }
    
    func hitAddExperienceApi(){
        
        guard let designation = designationTxt?.text else { return }
        guard let  business =  businessTxt?.text else{ return
        }
        guard let  location =  locationTxt?.text else{ return
        }
        guard let startYear = designationTxt?.text else { return }
        guard let  endYear =  businessTxt?.text else{ return
        }
        
        let addExperienceDict =  [
            "designation": designation,
            "business": business,
            "location": location,
            "start_year":startYear,
            "end_year":endYear

            ] as [String : Any]
        if (Reachability.init()?.isReachable)! {
            Utility.showLoader()
            self.addBrandExperience(addExperienceObj: addExperienceDict, completion:
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
    
    
    func pickUp(_ textField : UITextField){
        // UIPickerView
        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.myPickerView?.delegate = self
        self.myPickerView?.dataSource = self
        self.myPickerView?.backgroundColor = UIColor.white
        textField.inputView = self.myPickerView
        
        
    }
    
    //MARK: private methods
    private func validateData() -> Bool {
        var isDataValid = true
        
        if let designation = designationTxt?.text?.trimmingCharacters(in: .whitespaces) {
            if (designation.count > kMaxCharacterLimit || designation.isEmpty){
                isDataValid = false
                self.errorDesignationLabel?.text = kInvalidDesignation
                self.errorDesignationLabel?.isHidden = false
                self.designationTxt?.addTextFieldBorderColorWidth(borderColor:kBorderRedColor,borderWidth:1.0)
            } else{
                self.errorDesignationLabel?.text = ""
                self.errorDesignationLabel?.isHidden = true
                self.designationTxt?.addTextFieldBorderColorWidth(borderColor:.clear,borderWidth:1.0)
            }
        }
        
        if let business = businessTxt?.text?.trimmingCharacters(in: .whitespaces) {
            if (business.count > kMaxCharacterLimit || business.isEmpty) {
                isDataValid = false
                self.errorBusinessLabel?.text = kInvalidBusiness
                self.errorBusinessLabel?.isHidden = false
         self.businessTxt?.addTextFieldBorderColorWidth(borderColor:kBorderRedColor,borderWidth:1.0)
            } else {
                self.errorBusinessLabel?.text = ""
                self.errorBusinessLabel?.isHidden = false
                self.businessTxt?.addTextFieldBorderColorWidth(borderColor:.clear,borderWidth:1.0)
            }
        }

        if let location = locationTxt?.text?.trimmingCharacters(in: .whitespaces) {
            if (location.count > kMaxCharacterLimit || location.isEmpty) {
                isDataValid = false
                self.errorLocationLabel?.text = kInvalidLocation
                self.errorLocationLabel?.isHidden = false
                self.locationTxt?.addTextFieldBorderColorWidth(borderColor: kBorderRedColor, borderWidth: 1.0)
            } else {
                self.errorLocationLabel?.text = ""
                self.errorLocationLabel?.isHidden = false
                self.locationTxt?.addTextFieldBorderColorWidth(borderColor: .clear, borderWidth: 1.0)
            }
        }
        
        if let startYear = startYearTxt?.text?.trimmingCharacters(in: .whitespaces) {
            if (startYear.count > kMaxCharacterLimit || startYear.isEmpty) {
                isDataValid = false
                self.errorStartYearLabel?.text = kInvalidStartYear
                self.errorStartYearLabel?.isHidden = false
                self.startYearView?.addViewBorderColorWidth(borderColor: kBorderRedColor, borderWidth: 1.0)
            } else {
                self.errorStartYearLabel?.text = ""
                self.errorStartYearLabel?.isHidden = false
                self.startYearView?.addViewBorderColorWidth(borderColor: .clear, borderWidth: 1.0)
            }
        }
        
        if let endYear = endYearTxt?.text?.trimmingCharacters(in: .whitespaces) {
            if (endYear.count > kMaxCharacterLimit || endYear.isEmpty) {
                isDataValid = false
                self.errorEndYearLabel?.text = kInvalidLocation
                self.errorEndYearLabel?.isHidden = false
                self.endYearView?.addViewBorderColorWidth(borderColor: kBorderRedColor, borderWidth: 1.0)
            } else {
                self.errorEndYearLabel?.text = ""
                self.errorEndYearLabel?.isHidden = false
                self.endYearView?.addViewBorderColorWidth(borderColor: .clear, borderWidth: 1.0)
            }
        }
        
        return isDataValid
    }
}

extension BYBBrandAddExperiencePopVC:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == designationTxt {
            addExperienceButton?.isUserInteractionEnabled = true
            self.errorDesignationLabel?.text = ""
            self.errorDesignationLabel?.isHidden = true
            self.designationTxt?.addTextFieldBorderColorWidth(borderColor:kBorderGreenColor,borderWidth:1.0)
        } else if textField == businessTxt  {
            addExperienceButton?.isUserInteractionEnabled = true
            businessTxt?.addTextFieldBorderColorWidth(borderColor:kBorderGreenColor,borderWidth:1.0)
        }
        else if textField == locationTxt  {
            addExperienceButton?.isUserInteractionEnabled = true
            locationTxt?.addTextFieldBorderColorWidth(borderColor:kBorderGreenColor,borderWidth:1.0)
        }
        else if textField == startYearTxt  {
          
            textField.tag = YearPassed.startYear.rawValue
            selectedTxt = textField.tag
            
            self.pickUp(textField)
            
            addExperienceButton?.isUserInteractionEnabled = true
            startYearView?.addViewBorderColorWidth(borderColor:kBorderGreenColor,borderWidth:1.0)
        }
        else if textField == endYearTxt  {
            textField.tag = YearPassed.endYear.rawValue
            
             selectedTxt = textField.tag
            self.pickUp(textField)
            
            addExperienceButton?.isUserInteractionEnabled = true
            endYearView?.addViewBorderColorWidth(borderColor:kBorderGreenColor,borderWidth:1.0)
        }
        
        addExperienceButton?.setTitleColor(.white, for: .normal)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
            if textField == designationTxt {
            self.designationTxt?.addTextFieldBorderColorWidth(borderColor:.clear,borderWidth:1.0)
            } else if textField == businessTxt  {
                businessTxt?.addTextFieldBorderColorWidth(borderColor:.clear,borderWidth:1.0)
            }
            else if textField == locationTxt  {
                locationTxt?.addTextFieldBorderColorWidth(borderColor:.clear,borderWidth:1.0)
            }
            else if textField == startYearTxt  {
                self.pickUp(textField)
                startYearView?.addViewBorderColorWidth(borderColor:.clear,borderWidth:1.0)
            }
            else if textField == endYearTxt  {
                self.pickUp(textField)
                endYearView?.addViewBorderColorWidth(borderColor:.clear,borderWidth:1.0)
            }
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension BYBBrandAddExperiencePopVC:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: kBoldAppFont, size: 14.0) ?? UIFont.systemFont(ofSize: 14.0),NSAttributedStringKey.foregroundColor:kLightGreenColor])
        return myTitle
    }
   
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return 70.0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selectedTxt == YearPassed.startYear.rawValue
        {
        self.startYearTxt?.text = pickerData[row]
        }
        else if selectedTxt == YearPassed.endYear.rawValue{
        self.endYearTxt?.text = pickerData[row]
           dateCompareStartEndDate()
        }
    }
    
}
