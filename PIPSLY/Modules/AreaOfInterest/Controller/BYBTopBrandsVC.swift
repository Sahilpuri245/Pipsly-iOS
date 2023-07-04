//
//  BYBTopBrandsVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 07/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

class BYBTopBrandsVC: BaseVC,BYBTopBrandService {

    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var btnJumpDashboard: UIButton?
    var placeholderView:PlaceholderView?
    var dataSource:[TopBrandModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupView() {
        self.collectionView?.register(TopBrandCell.self)
        requestToGetTopBrands()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func tapDashboard(_ sender: UIButton) {
        let dashboardVC = BYBDashboardVC.instantiateWithStoryboard(fromAppStoryboard: .userProfile)
        self.navigationController?.pushViewController(dashboardVC, animated: true)
    }
    
    func requestToGetTopBrands() {
        if (Reachability.init()?.isReachable)! {
            Utility.showLoader()
            guard let userID = AppManager.shared().userObj.userID else {return}
            self.getTopBrands(userID) { (isSuccess, msg, brandList, error) in
                Utility.dismissLoader()
                if isSuccess {
                    self.dataSource = brandList
                    if self.dataSource?.count == 0 || self.dataSource == nil{
                        guard let view = PlaceholderView.instanceFromNib() as? PlaceholderView else { return }
                        self.placeholderView = view
                        self.collectionView?.backgroundView = self.placeholderView
                    }
                    self.collectionView?.reloadData()
                }else {
                     self.showAlertViewController(viewController: self, withAlertTitle: kAppName, withAlertMessage: msg)
                }
            }
        } else {
            self.showAlertOnWindow()
        }
    }
    
}
