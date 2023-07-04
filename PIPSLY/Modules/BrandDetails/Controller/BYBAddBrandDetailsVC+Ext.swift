//
//  BYBAddBrandDetailsVC+Ext.swift
//  PIPSLY
//
//  Created by KiwiTech on 12/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation
import UIKit

extension BYBAddBrandDetailsVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AreaInterestHeader") as? AreaInterestHeader else {return UIView()}
        headerView.delegate = self
        headerView.configureHeaderWithData(model: headerObj)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
}

