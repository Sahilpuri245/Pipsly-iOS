//
//  BYBCalenderPickerView.swift
//  PIPSLY
//
//  Created by KiwiTech on 19/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

enum PickerViewType : String {
    case year    = "year"
    var value : String {
        return self.rawValue
    }
}

protocol BYBCalenderPickerViewDelegate {
    func setSelectedValue(year : String)
}

class BYBCalenderPickerView: UIView {
    var pickerCellHeight : CGFloat = 45.0 * SCALE_FACTOR
    var myPickerView : UIPickerView!
    var pickerData = [String]()
    let today = Date()
    let currentCalendar = Calendar.current
    var delegate : BYBCalenderPickerViewDelegate?
    var pickerType : PickerViewType? = .year
    
    class func getView() -> BYBCalenderPickerView {
        return (Bundle.main.loadNibNamed("BYBCalenderPickerView", owner: self, options: nil)!.last! as! BYBCalenderPickerView)
    }
    
     //MARK: Get year datasource
    func last15year(){
        var yearComponents: DateComponents? = currentCalendar.dateComponents([.year], from: today)
        let currentYear = Int(yearComponents!.year!)
        for currentdata in kMinYear..<currentYear+1 {
            pickerData.append(String(currentdata))
            pickerData.reverse()
        }
    }
    
    //MARK: Setup Picker
     func ConfigurePicker(){
        if pickerType == PickerViewType.year {
           last15year()
        }
        self.myPickerView = UIPickerView(frame:CGRect(x: 50.0, y: 0.0, width: self.frame.size.width - 100.0, height: kYearPickerHeight))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        self.addSubview(self.myPickerView)
    }
}

//MARK: Picker Delegates and Datasource
extension BYBCalenderPickerView:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let vw = view != nil ? view! : UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height:pickerCellHeight))
        var lbl: UILabel? = vw.viewWithTag(-10) as? UILabel
        if lbl == nil {
            lbl = UILabel.init(frame: CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height:pickerCellHeight))
        }
        
        lbl?.textColor = kDarkGreenColor
        lbl?.tag = -10;
        lbl?.text = pickerData[row]
        lbl?.textAlignment = .center
        lbl?.backgroundColor = .clear
        lbl?.font = UIFont(name: FontName.Bold.rawValue, size: 14.0 * SCALE_FACTOR)!
        vw.addSubview(lbl!)
        
        var lineView: UIView? = vw.viewWithTag(-20)
        if lineView == nil {
            lineView = UIView.init(frame: CGRect.init(x: 0.0, y: pickerCellHeight - 1, width: UIScreen.main.bounds.width, height:1.0))
        }
        
        lineView?.backgroundColor = UIColor.init(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        vw.addSubview(lineView!)
        return vw
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerCellHeight
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.setSelectedValue(year: pickerData[row])
    }
}
