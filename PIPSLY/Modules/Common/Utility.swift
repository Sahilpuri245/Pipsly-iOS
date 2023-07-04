//
//  Utility.swift
//  PIPSLY
//
//  Created by KiwiTech on 20/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
import SVProgressHUD

class Utility: NSObject {
    
    class func showAlertViewControllertMessage(alertTitle: String, alertmessage: String, okButtonTitle: String, calcelButtonTitle: String?, ViewController: UIViewController?, and block: @escaping (_ success: Bool) -> Void)
    {
        Utility.dismissLoader()
        let alertController = UIAlertController(title:"", message: alertmessage, preferredStyle: .alert)
        var cancelAction = UIAlertAction()
        if(calcelButtonTitle != nil) {
            cancelAction = UIAlertAction(title: calcelButtonTitle, style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
                block(false)
            })
        }
        let okAction = UIAlertAction(title: okButtonTitle, style: .default, handler: { (action: UIAlertAction!) in
            block(true)
        })
        
        alertController.addAction(okAction)
        if(calcelButtonTitle != nil) {
            alertController.addAction(cancelAction)
        }
        
        if(ViewController != nil){
            ViewController?.present(alertController, animated: true, completion: nil)
        } else{
            AppDelegate.getDelegate().window?.rootViewController?.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    class func enableButton(btn : UIButton){
        btn.titleLabel?.alpha = 1.0
        btn.isUserInteractionEnabled = true
    }
    
    class func disableButton(btn : UIButton){
        btn.titleLabel?.alpha = 0.5
        btn.isUserInteractionEnabled = false
    }
    
    class func setupYearTextfield(textfield : UITextField?){
        let vw = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 1.1, height: 1.1))
        vw.isUserInteractionEnabled = false
        let toolBar = UIToolbar()
        toolBar.setItems([], animated: false)
        if let txtf = textfield {
            txtf.inputView = vw
            textfield?.inputAccessoryView = toolBar
        }
    }
    
    class func addPickerForYearTextfield(frameY : CGFloat, view : UIView, viewContDelegate : BYBCalenderPickerViewDelegate, pickerType : PickerViewType){
        UIView.animate(withDuration: Double(0.3), animations: {
        var yearPickerview = BYBCalenderPickerView()
        yearPickerview = BYBCalenderPickerView.getView()
        yearPickerview.pickerType = pickerType
        yearPickerview.ConfigurePicker()
        yearPickerview.delegate = viewContDelegate
        yearPickerview.tag = -9999
        yearPickerview.frame = CGRect.init(x: 0.0, y: frameY, width: UIScreen.main.bounds.width, height: kYearPickerHeight)
        view.addSubview(yearPickerview)
        yearPickerview.bringSubview(toFront: view)
        })
    }
    
    class func removePickerForYearTextfield(viewCont : UIViewController){
        if let vw = viewCont.view.viewWithTag(-9999) {
            vw.removeFromSuperview()
        }
    }
    
    class func getRoundedShadow(_ view: UIView, _ shadowOpacity: Float, _ shadowRadius: CGFloat, _ shadowOffset: CGSize = CGSize(width: 0, height: 0), _ shadowColor: UIColor = UIColor.black, _ borderColor: UIColor = UIColor.white, _ borderWidth: CGFloat = 0.2, _ cornerRadius: CGFloat = 10) {
        
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.masksToBounds = true
        view.clipsToBounds = false
        
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.rasterizationScale = UIScreen.main.scale
        view.layer.shouldRasterize = true
    }
    
    class func shadowOnViewBottom(_ view: UIView) {
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        view.layer.shadowOpacity = 0.36
        view.layer.shadowRadius = 0.0
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 6.0
    }
    
    class func getNameInitials(name:String?) -> String {
        guard let name = name?.trimmingCharacters(in: .whitespaces) else { return "" }
        var str = ""
        if let _ = name.rangeOfCharacter(from: .whitespaces) {
            let fullNameArr = name.split{$0 == " "}.map(String.init)
            if fullNameArr[0].count > 0 {
                str = String(fullNameArr[0].uppercased().prefix(1))
            }
            if fullNameArr[0].count > 0 {
                str =  str + String(fullNameArr[1].uppercased().prefix(1))
            }
            return str
        } else {
            if name.count > 1 {
            str = String(name.uppercased().prefix(2))
            } else {
                 str = String(name.uppercased().prefix(1))
            }
          return str
        }
    }
    
    class func getDateFromString(_ dateString: String, withFormat: String? = "MM-dd-yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        return date
    }
    class func getDatefromDateTimeString (_ dateTimeString: String, withFormat: String? = "yyyy-MM-dd HH:mm:ss", toFormat: String? = "yyyy-MM-dd") -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        if (dateFormatter.date(from: dateTimeString) != nil) {
            let date = dateFormatter.date(from: dateTimeString)
            dateFormatter.dateFormat = toFormat
            let dateStr = dateFormatter.string(from: date!)
            let dateFormatted = dateFormatter.date(from: dateStr)
            return dateFormatted
        }
        return Date()
    }

    class func getAttributedString(string: String? = nil, withAllignment allignment: NSTextAlignment) -> NSMutableAttributedString? {
        guard let string = string else {
            return nil
        }
        let attributedString = NSMutableAttributedString(
            string: string,
            attributes: [NSAttributedStringKey.font: UIFont(name: "Muli-Regular", size: 13.0)!,
                         NSAttributedStringKey.foregroundColor: UIColor.colorWithRGBA(redValue: 176, greenValue: 176, blueValue: 186, alpha: 1.0)])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = allignment
        paragraphStyle.lineSpacing = 7
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
    class func getRange(string: String, substring: String) -> NSRange? {
        let mainString = string.lowercased()
        let subString = (substring.trimmingCharacters(in: .whitespacesAndNewlines)).lowercased()
        
        if let range = mainString.range(of: subString) {
            let startPos = string.distance(from: mainString.startIndex, to: range.lowerBound)
            return NSRange(location: startPos, length: subString.count)
        }
        return nil
    }
    
    class func getAttributtedString(str: String, range: NSRange, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: str)
        
        myMutableString.setAttributes([NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: color], range: range)
        return myMutableString
    }

    
    class func getDateForChatFromString(_ dateString: String, withFormat: String? = "yyyy-MM-dd HH:mm:ss") -> Date! {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        guard let date = dateFormatter.date(from: dateString) else {
            return Date()
        }
        return date
    }
    
    class func getDateFromString(str: String?) -> String {
        guard let dateString = str else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = kDateFormatt
        if let date =  dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let finalDate = dateFormatter.string(from: date)
            return finalDate
        }
        return ""
    }
    
    class func convertDateFormatter(date: String) -> String {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        dateFormatter.locale = Locale(identifier: "your_loc_id")
        let convertedDate = dateFormatter.date(from: date)
        
        guard dateFormatter.date(from: date) != nil else {
            //assert(false, "no date from string")
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
            let convertedDate = dateFormatter.date(from: date)
            guard dateFormatter.date(from: date) != nil else {
                return ""
            }
            dateFormatter.dateFormat = "MMM dd, yyyy "
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
            if let convertedDate = convertedDate {
                let timeStamp = dateFormatter.string(from: convertedDate)
                return timeStamp
            }
            return ""
        }
        
        // dateFormatter.dateFormat = "yyyy MMM HH:mm EEEE"///this is what you want to convert format
        dateFormatter.dateFormat = "MMM dd, yyyy "
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        if let convertedDate = convertedDate {
            let timeStamp = dateFormatter.string(from: convertedDate)
            return timeStamp
        }
        return ""
    }
    
    class func checkTextSufficientComplexity( text : String) -> Bool{
        
        var isValidPass = true
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: text)
        if !capitalresult {
            isValidPass = false
            return isValidPass
        }
        print("\(capitalresult)")
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: text)
        print("\(numberresult)")
        if !numberresult {
            isValidPass = false
            return isValidPass
        }

        return isValidPass
    }
    
    class func getStringFromDate(_ date: Date, inFormat format: String? = "MM/dd/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    // Get Screen Scale factor
    class func getScreenScaleFactor() -> CGFloat {
        if UIScreen.main.isPortrait() {
            return UIScreen.main.bounds.size.width / 375.0
        } else {
            return UIScreen.main.bounds.size.height / 375.0
        }
    }
    
    class func showLoader() -> Void
    {
        let when = DispatchTime.now()  // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when)
        {
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.custom)
            SVProgressHUD.show()
        }
        
    }
    
    class func dismissLoader() -> Void {
        
        let when = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            SVProgressHUD.dismiss()
            
        }
    }
    
    class func showToastMessage(_ msgString: String) {
        DispatchQueue.main.async(execute: {
            ToastCenter.default.cancelAll()
            Toast(text: msgString, duration: Delay.long).show()
        })
    }

}

struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_5_OR_LESS         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH <= 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_X         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}

