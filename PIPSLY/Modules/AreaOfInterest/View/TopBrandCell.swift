//
//  TopBrandCell.swift
//  PIPSLY
//
//  Created by KiwiTech on 07/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

class TopBrandCell: BaseCollectionCell {

    @IBOutlet weak var imgProfile: UIImageView?
    @IBOutlet weak var lblUserName: UILabel?
    @IBOutlet weak var lblCategories: UILabel?
    @IBOutlet weak var btnConnect: UIButton?
    @IBOutlet weak var stackRequestSent: UIStackView?
    @IBOutlet weak var lblInitials: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.stackRequestSent?.isHidden = true
    }
    
    func configureCellWithData(model:TopBrandModel?)  {
        guard let model = model else { return }
        if let imageUrl = model.profilePic {
            self.imgProfile?.sd_setImage(with: NSURL(string: imageUrl) as URL?, placeholderImage: UIImage(named: ""), options: .refreshCached) { (image, _, _, _) in
                        if (image != nil) {
                            self.imgProfile?.image = image
                        }
                }
        } else {
            guard let name = AppManager.shared().userObj.name else {return}
            self.lblInitials?.text = String(name.uppercased().prefix(2))
        }
        self.lblUserName?.text = model.name
        if let arr = model.specialization {
            self.lblCategories?.text = arr.joined(separator: ",")
        }
        
    }

    @IBAction func tapConnect(_ sender: UIButton) {
        sender.isHidden = true
        self.stackRequestSent?.isHidden = false
    }
}
