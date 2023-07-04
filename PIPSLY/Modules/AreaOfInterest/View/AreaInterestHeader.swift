//
//  AreaInterestHeader.swift
//  PIPSLY
//
//  Created by KiwiTech on 05/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
protocol AreaInterestHeaderDelegate:class {
    func didSelectUpdateProfile()
}

struct AreaInterestHeaderModel {
    var profileImage:UIImage?
    var title:String?
    var msg:String?
    var showIndicator:Bool
    var imageData: Data? {
        if let image = profileImage {
            return UIImageJPEGRepresentation(image, 0.99)
        } else {
            return nil
        }
    }
    
    init(profileImg:UIImage?,title:String?,msg:String?,isShow:Bool) {
        self.profileImage = profileImg
        self.title = title
        self.msg = msg
        self.showIndicator = isShow
    }
}

class AreaInterestHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var lblMsg: UILabel?
    @IBOutlet weak var imgViewProfile: UIImageView?
    @IBOutlet weak var lblName: UILabel?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    var delegate:AreaInterestHeaderDelegate?
    var inProgress:Bool = false
    
    private func showIndicator(isShow:Bool) {
        inProgress = isShow
        if isShow {
            self.activityIndicator?.isHidden = false
            self.activityIndicator?.startAnimating()
        } else {
            self.activityIndicator?.isHidden = true
            self.activityIndicator?.stopAnimating()
        }
    }
    
    func configureHeaderWithData(model:AreaInterestHeaderModel?){
        self.lblTitle?.text = model?.title
        self.lblMsg?.text = model?.msg
        guard let model = model else { return  }
        if let image = model.profileImage {
            self.imgViewProfile?.image = image
            self.lblName?.text = ""
        } else {
            self.imgViewProfile?.image = nil
            guard let name = AppManager.shared().userObj.name else {return}
            self.lblName?.text = Utility.getNameInitials(name: name)
        }
        showIndicator(isShow: model.showIndicator)
    }
    
    //MARK: IBAction methods
    @IBAction func tapUpdateProfileImage(_ sender: UIButton) {
        if !inProgress {
            delegate?.didSelectUpdateProfile()
        }
    }
 
}
