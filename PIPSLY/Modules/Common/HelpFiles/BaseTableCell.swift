//
//  BaseTableCell.swift
//  YAT
//
//  Created by KiwiTech on 10/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation

import UIKit
class BaseTableCell: UITableViewCell, NibLoadableView, ReusableView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
