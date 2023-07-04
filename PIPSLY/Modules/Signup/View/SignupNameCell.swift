//
//  SignupNameCell.swift
//  PIPSLY
//
//  Created by KiwiTech on 21/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
let kShow = "Show"
let kHide = "Hide"
let kMaxWidth = 48.0
let kMinWidth = 10.0

protocol SignupNameCellDelegate:class {
    func didOpenGooglPlacepicker()
    func didUpdateSignupfield(inputString: String?, cellSubtype:SignupCellSubType)
}

class SignupNameCell: BaseTableCell {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint?
    @IBOutlet weak var widthConstraint: NSLayoutConstraint?
    @IBOutlet weak var viewBorder: UIView?
    @IBOutlet weak var txtName: UITextField?
    @IBOutlet weak var btnShow: UIButton?
    @IBOutlet weak var lblHelpmsg: UILabel?
    @IBOutlet weak var lblErrorMsg: UILabel?
    var currentDate: Date?
    var modelObj:SignupCellModel?
    var datePicker:UIDatePicker!
    weak var delegate:SignupNameCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker = UIDatePicker()
        datePicker.setTenYearValidation()
        datePicker.datePickerMode = .date
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func didSelectDate()  {
        if datePicker != nil {
            txtName?.resignFirstResponder()
            handleDateTimePicker(sender: datePicker)
        }
    }
    
    func configureCellWithData(model:SignupCellModel?) {
        guard let model = model else { return }
        modelObj = model
        self.txtName?.placeholder = model.placeholder
        self.txtName?.text = model.value
        self.lblHelpmsg?.text = model.helpMsg
        switch model.cellSubtype {
        case .name , .email:
            widthConstraint?.constant = CGFloat(kMinWidth)
        case .password:
            widthConstraint?.constant = CGFloat(kMaxWidth)
            self.btnShow?.setTitle(kShow, for: .normal)
            self.btnShow?.setTitle(kHide, for: .selected)
            self.btnShow?.setImage(nil, for: .normal)
            self.btnShow?.setTitleColor(.black, for: .normal)

        case .birthday:
            self.txtName?.text = self.getDateString(model: model)
            self.btnShow?.setTitle("", for: .normal)
            self.btnShow?.setImage(UIImage.init(named: model.imageName!), for: .normal)
            widthConstraint?.constant = CGFloat(kMaxWidth)
        case .address:
            self.btnShow?.setTitle("", for: .normal)
            self.btnShow?.setImage(UIImage.init(named: model.imageName!), for: .normal)
            widthConstraint?.constant = CGFloat(kMaxWidth)
        default:
            break
        }
        showHidebutton(isHide: model.isButtonHide)
        setFieldType(cellSubType: model.cellSubtype)
        checkValidationLayerColor(cellSubType: model.cellSubtype)
    }
    
    func getDateString(model:SignupCellModel?) -> String {
        guard let model = model else { return ""}
        var resultDate = ""
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = kDobToFormat
        if let value =  model.value {
            if !value.isEmpty {
                if let showDate = inputFormatter.date(from:value) {
                    inputFormatter.dateFormat = kDateFormatt
                    resultDate = inputFormatter.string(from: showDate)
                }
            }
        }
        return resultDate
    }
    
    func checkValidationLayerColor(cellSubType: SignupCellSubType) {
        if modelObj?.state == .invalid {
            self.lblErrorMsg?.text = modelObj?.errorMSg
            self.lblErrorMsg?.backgroundColor = kRedColor
            self.lblHelpmsg?.textColor = cellSubType == .password ? kBorderRedColor : kGrayColor
            self.viewBorder?.layer.borderColor = kBorderRedColor.cgColor
            self.viewBorder?.layer.borderWidth = 1.0
        } else {
            self.lblErrorMsg?.text = ""
            self.lblErrorMsg?.backgroundColor = .clear
            self.lblHelpmsg?.textColor = kGrayColor
            self.viewBorder?.layer.borderColor = UIColor.clear.cgColor
            self.viewBorder?.layer.borderWidth = 1.0
        }
    }
    
    func showHidebutton(isHide:Bool)  {
        self.btnShow?.isHidden = isHide
    }
    
    func setFieldType(cellSubType: SignupCellSubType) {
        switch cellSubType {
        case .name:
            self.txtName?.keyboardType = .default
            self.txtName?.autocapitalizationType = .words
            self.txtName?.isSecureTextEntry = false
        case .email:
            self.txtName?.keyboardType = .emailAddress
            self.txtName?.isSecureTextEntry = false
        case .password:
            self.txtName?.keyboardType = .default
            self.txtName?.isSecureTextEntry = true
        case .birthday:
            self.txtName?.isSecureTextEntry = false
            txtName?.addDoneOnKeyboardWithTarget(self, action: #selector(didSelectDate))
        case .address:
            self.txtName?.isSecureTextEntry = false
        default:
            break
        }
    }
    
    @objc func handleDateTimePicker(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = kDateFormatt
        txtName?.text = formatter.string(from: datePicker.date)
        let formatter1 = DateFormatter()
        formatter1.dateFormat = kDobToFormat
        let date = formatter1.string(from: datePicker.date)
        delegate?.didUpdateSignupfield(inputString: date, cellSubtype: .birthday)
    }
    
    //MARK: IBAction methods
    @IBAction func tapFieldsActionButton(_ sender: UIButton) {
        if modelObj?.cellSubtype == .password {
            if !(self.txtName?.text?.isEmpty)!{
                self.txtName?.isSecureTextEntry = sender.isSelected
                sender.isSelected = !sender.isSelected
            }
        } else if modelObj?.cellSubtype == .birthday || modelObj?.cellSubtype == .address{
            txtName?.becomeFirstResponder()
        }
    }
}

extension SignupNameCell:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.viewBorder?.layer.borderColor = kBorderGreenColor.cgColor
        self.viewBorder?.layer.borderWidth = 1.0
        self.lblHelpmsg?.textColor = kGrayColor
        self.lblErrorMsg?.text = ""
        self.lblErrorMsg?.backgroundColor = .clear
        if modelObj?.cellSubtype == .birthday {
            textField.inputView = datePicker
            datePicker.date = setDatePickerDate()
            datePicker.addTarget(self, action: #selector(handleDateTimePicker(sender:)), for: .valueChanged)
        } else if modelObj?.cellSubtype == .address {
            delegate?.didOpenGooglPlacepicker()
        } else {
            textField.inputView = nil
            textField.becomeFirstResponder()
        }
    }
    
    func setDatePickerDate() -> Date{
        var lastDate = Date()
        guard let dateString = modelObj?.value else { return lastDate }
        if !(dateString.isEmpty) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = kDobToFormat
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
            guard let date = dateFormatter.date(from: dateString) else {
                return lastDate
            }
            lastDate = date
        }
        return lastDate
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let modelObj = modelObj else { return false }
        if (textField.textInputMode?.primaryLanguage == "emoji") || textField.textInputMode?.primaryLanguage == nil {
            return false
        }
        
        let textobj = (textField.text ?? "") as NSString
        let resultString = textobj.replacingCharacters(in: range, with: string)
        if modelObj.cellSubtype == .name {
            if resultString.count > kMaxNameLimit {
                return false
            }
            do {
                let regex = try NSRegularExpression(pattern: "*[^A-Za-z ].*", options: [])
                if regex.firstMatch(in: resultString, options: [], range: NSMakeRange(0, resultString.count)) != nil {
                    return false
                }
            }catch {
            }
        }
        delegate?.didUpdateSignupfield(inputString: resultString, cellSubtype: modelObj.cellSubtype)
        return true
    }
        
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.viewBorder?.layer.borderColor = UIColor.clear.cgColor
        self.viewBorder?.layer.borderWidth = 1.0
        if modelObj?.cellSubtype == .password {
            delegate?.didUpdateSignupfield(inputString: textField.text, cellSubtype: .password)
        }
    }
}
