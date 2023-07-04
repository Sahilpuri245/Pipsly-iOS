//
//  BYBAddBrandDetailsVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 12/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
let kBrandMsg = "Thank you for creating a Pipsly account."

class BYBAddBrandDetailsVC: BaseVC,AreaInterestHeaderDelegate {
   
    @IBOutlet weak var tblView: UITableView?
    var headerObj:AreaInterestHeaderModel?
    var dataSource = AddBrandDetailModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupView(){
        let title = "Hi " + "\(AppManager.shared().userObj.name?.capitalizingFirstLetter() ?? "")!"
        headerObj = AreaInterestHeaderModel(profileImg: nil, title: title, msg: kBrandMsg, isShow: false)
        let headerNib = UINib.init(nibName: "AreaInterestHeader", bundle: Bundle.main)
        tblView?.register(headerNib, forHeaderFooterViewReuseIdentifier: "AreaInterestHeader")

    }

    func didSelectUpdateProfile() {
        
    }
        
}
