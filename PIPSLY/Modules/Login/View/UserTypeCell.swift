//
//  UserTypeCell.swift
//  PIPSLY
//
//  Created by KiwiTech on 29/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
let kBottomDefaultX:CGFloat = -71
let kBottomUpdateX:CGFloat = 0
let kBottomDefault:CGFloat = -37
let kBottomUpdate:CGFloat = 48
let kBottomProceedDefault:CGFloat = 34
let kBottomProceedX:CGFloat = -71

protocol UserTypeCellDelegate:class {
    func didSelectBackButton()
    func didSelectUserType(type:UserType?)
}

class UserTypeCell: BaseCollectionCell {

    @IBOutlet weak var lblBuyer: UILabel?
    @IBOutlet weak var lblBuyerMsg: UILabel?
    @IBOutlet weak var lblBrand: UILabel?
    @IBOutlet weak var lblBrandMsg: UILabel?
    @IBOutlet weak var lblBusiness: UILabel?
    @IBOutlet weak var lblBusinessMsg: UILabel?
    @IBOutlet weak var imgViewBuyer: UIImageView?
    @IBOutlet weak var imgViewBusiness: UIImageView?
    @IBOutlet weak var imgVIewBrand: UIImageView?
    @IBOutlet weak var viewBusiness: UIView?
    @IBOutlet weak var viewBrand: UIView?
    @IBOutlet weak var viewBuyer: UIView?
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint?
    @IBOutlet weak var bottomProceedConstraint: NSLayoutConstraint?
    @IBOutlet weak var lblProceed: UILabel?
    @IBOutlet weak var startStackView: UIStackView?
    weak var delegate:UserTypeCellDelegate?
    var userType:UserType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bottomConstraint?.constant = DeviceType.IS_IPHONE_X ? kBottomDefaultX : kBottomDefault
        self.bottomProceedConstraint?.constant = DeviceType.IS_IPHONE_X ? kBottomProceedX : kBottomProceedDefault
        startStackView?.isHidden = true
        self.layoutIfNeeded()
    }
    
    func updateAttributes()  {
        resetUserSelection()
        self.userType = nil
        self.bottomConstraint?.constant = DeviceType.IS_IPHONE_X ? kBottomDefaultX : kBottomDefault
        startStackView?.isHidden = true
        self.lblProceed?.isHidden  = false
        self.layoutIfNeeded()
    }
    
    //MARK: IBAction methods
    @IBAction func tapBack(_ sender: UIButton) {
        delegate?.didSelectBackButton()
    }
    
    @IBAction func tapBuyer(_ sender: UIButton) {
        userType = .buyer
        resetUserSelection()
        self.viewBuyer?.backgroundColor = kBorderGreenColor
        self.lblBuyer?.textColor = .white
        self.lblBuyerMsg?.textColor = .white
        self.imgViewBuyer?.isHidden = false
        self.lblProceed?.isHidden = true
        startStackView?.isHidden = false
        UIView.animate(withDuration: Double(0.5), animations: {
            self.bottomConstraint?.constant = DeviceType.IS_IPHONE_X ? kBottomUpdateX : kBottomUpdate
            self.layoutIfNeeded()
        })
    }
    
    @IBAction func tapBrand(_ sender: UIButton) {
        userType = .brand
        resetUserSelection()
        self.viewBrand?.backgroundColor = kBorderGreenColor
        self.lblBrandMsg?.textColor = .white
        self.lblBrand?.textColor = .white
        self.imgVIewBrand?.isHidden = false
        self.lblProceed?.isHidden = true
        startStackView?.isHidden = false
        UIView.animate(withDuration: Double(0.5), animations: {
            self.bottomConstraint?.constant = DeviceType.IS_IPHONE_X ? kBottomUpdateX : kBottomUpdate
            self.layoutIfNeeded()
        })
    }
    
    @IBAction func tapBusiness(_ sender: UIButton) {
        userType = .bussiness
        resetUserSelection()
        self.viewBusiness?.backgroundColor = kBorderGreenColor
        self.lblBusinessMsg?.textColor = .white
        self.lblBusiness?.textColor = .white
        self.imgViewBusiness?.isHidden = false
        self.lblProceed?.isHidden = true
        startStackView?.isHidden = false
        UIView.animate(withDuration: Double(0.5), animations: {
            self.bottomConstraint?.constant = DeviceType.IS_IPHONE_X ? kBottomUpdateX : kBottomUpdate
            self.layoutIfNeeded()
        })
    }
    
    @IBAction func tapSelectUserType(_ sender: UIButton) {
        guard let userype = userType else { return }
        delegate?.didSelectUserType(type: userype)
    }
    
    func resetUserSelection() {
        self.viewBuyer?.backgroundColor = .white
        self.viewBrand?.backgroundColor = .white
        self.viewBusiness?.backgroundColor = .white
        self.lblBrand?.textColor = .black
        self.lblBusiness?.textColor = .black
        self.lblBuyer?.textColor = .black
        self.lblBrandMsg?.textColor = .black
        self.lblBusinessMsg?.textColor = .black
        self.lblBuyerMsg?.textColor = .black
        self.imgVIewBrand?.isHidden = true
        self.imgViewBusiness?.isHidden = true
        self.imgViewBuyer?.isHidden = true
    }
    
}
