//
//  BYBBrandsServiceTableViewCell.swift
//  PIPSLY
//
//  Created by KiwiTech on 06/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

class BYBBrandsServiceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var brandView: UIView?
    @IBOutlet weak var brandImage: UIImageView?
    @IBOutlet weak var brandNameLabel: UILabel?
    @IBOutlet weak var serviceNameLabel: UILabel?
    @IBOutlet weak var iconRatingImage: UIImageView?
    
    @IBOutlet weak var ratingView: UIView?
    @IBOutlet weak var ratingLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCellWithData(model:BYBBrandsModel?)  {
        guard let model = model else { return  }
        
        brandNameLabel?.text = " \(model.name ?? "") "
        //   brandNameLabel.addImageWith(name: "iconConnected", behindText: true)
        if let specialization = model.specialization {
            let arrayOfspecialization = specialization.joined(separator: ", ")
            serviceNameLabel?.text = arrayOfspecialization
        }
        self.configureRatingValues(ratingValue:1)
        brandImage?.addImageBorderColorWidth(borderColor:.clear,borderWidth:0.0)
        if let brandUserImage = model.profilePic {
            let profileUrl = URL(string: APIURL.baseUrl + brandUserImage)
            brandImage?.sd_setImage(with: profileUrl, placeholderImage: UIImage(named: APPImage.kIconDp.rawValue))
            
        }
        if let doubleRating = model.rating?.doubleValue{
            
            let ratingValueString  = String(format: "%.1f",doubleRating)
            hideRatingLabelIcon(ratingText:ratingValueString,RatingTextColor:.white,ratingLabelViewBackgroundColor:kGreenColor,ratingImageBoolValue:false)
            self.configureRatingValues(ratingValue:doubleRating)
        }else{
            
            hideRatingLabelIcon(ratingText:"-",RatingTextColor:kGrayColor,ratingLabelViewBackgroundColor:kLightGrayColor,ratingImageBoolValue:true)
        }
    }
    
    func hideRatingLabelIcon(ratingText:String,RatingTextColor:UIColor,ratingLabelViewBackgroundColor:UIColor,ratingImageBoolValue:Bool){
        ratingLabel?.text = ratingText
        ratingLabel?.textColor = RatingTextColor
        ratingLabel?.backgroundColor = ratingLabelViewBackgroundColor
        ratingView?.backgroundColor = ratingLabelViewBackgroundColor
        iconRatingImage?.isHidden = ratingImageBoolValue
    }
    // rating  color according to  Value change
    func configureRatingValues(ratingValue:Double){
        if ratingValue == 1.0 || ratingValue < 2.0 {
            ratingLabel?.backgroundColor = kGreenColor
            
        }
        else if ratingValue == 2.0 || ratingValue < 3.0{
            ratingLabel?.backgroundColor = kYellowColor
        }
        else if ratingValue == 3.0 || ratingValue < 4.0{
            ratingLabel?.backgroundColor = kLightShadowGreenColor
        }
        else if ratingValue == 4.0 || ratingValue < 5.0 {
            ratingLabel?.backgroundColor =  kGreenColor
        }
        else{
            ratingLabel?.backgroundColor = .green
        }
        
    }
    
}
