//
//  BYBDashboardVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 07/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
class BYBDashboardVC: BaseVC {
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnSearchBrandBusinessAction(_ sender: Any) {
          let brandBusinessSearchVC = BYBSearchBrandBusinessVC.instantiateWithStoryboard(fromAppStoryboard: .userProfile)
        self.navigationController?.pushViewController(brandBusinessSearchVC, animated: true)
    }
    
}
