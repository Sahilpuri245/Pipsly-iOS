//
//  AddExperienceCell.swift
//  PIPSLY
//
//  Created by KiwiTech on 20/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

class AddExperienceCell: UITableViewCell {

    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var endDateBtn: UIButton!
    @IBOutlet weak var startDateBtn: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
