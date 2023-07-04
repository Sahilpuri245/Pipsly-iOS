//
//  SignupGenderCell.swift
//  PIPSLY
//
//  Created by KiwiTech on 21/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
protocol SignupGenderCellDelegate:SignupNameCellDelegate {
}

enum Gender:String {
    case male = "1"
    case female = "2"
}

class SignupGenderCell: BaseTableCell {

    @IBOutlet weak var btnFemale: UIButton?
    @IBOutlet weak var btnMale: UIButton?
    weak var delegate:SignupGenderCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCellWithData(model:SignupCellModel?) {
        guard let model = model else { return }
        updateGender()
        if let value = model.value {
            if value == Gender.female.rawValue {
                self.btnMale?.isSelected = false
                self.btnFemale?.isSelected = true
                self.btnFemale?.setTitleColor(UIColor.colorWithRGBA(redValue: 0, greenValue: 0, blueValue: 0, alpha: 1.0), for: .normal)
            } else {
                self.btnMale?.isSelected = true
                self.btnFemale?.isSelected = false
                self.btnMale?.setTitleColor(UIColor.colorWithRGBA(redValue: 0, greenValue: 0, blueValue: 0, alpha: 1.0), for: .normal)
            }
        }
    }
    
    @IBAction func tapFemale(_ sender: UIButton) {
        updateGender()
        sender.isSelected = true
        sender.setTitleColor(UIColor.colorWithRGBA(redValue: 0, greenValue: 0, blueValue: 0, alpha: 1.0), for: .normal)
        delegate?.didUpdateSignupfield(inputString: Gender.female.rawValue, cellSubtype: .gender)
    }
    
    @IBAction func tapMale(_ sender: UIButton) {
        updateGender()
        sender.isSelected = true
        sender.setTitleColor(UIColor.colorWithRGBA(redValue: 0, greenValue: 0, blueValue: 0, alpha: 1.0), for: .normal)
        delegate?.didUpdateSignupfield(inputString: Gender.male.rawValue, cellSubtype: .gender)

    }
    
    func updateGender()  {
        self.btnMale?.isSelected = false
        self.btnFemale?.isSelected = false
        self.btnFemale?.setTitleColor(UIColor.colorWithRGBA(redValue: 204, greenValue: 204, blueValue: 204, alpha: 1.0), for: .normal)
        self.btnMale?.setTitleColor(UIColor.colorWithRGBA(redValue: 204, greenValue: 204, blueValue: 204, alpha: 1.0), for: .normal)
    }
    
}
