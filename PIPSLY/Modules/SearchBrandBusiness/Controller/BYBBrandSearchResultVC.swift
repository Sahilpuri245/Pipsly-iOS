//
//  BYBBrandSearchResultVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 17/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

class  BYBBrandSearchResultVC: BaseVC{
   
    @IBOutlet weak var serviceBrandCountLabel: UILabel?
    @IBOutlet weak var noDataView: UIView?
    @IBOutlet weak var noDataFoundLabel: UILabel?
    @IBOutlet weak var btnFilterBy: UIButton?
    @IBOutlet weak var tableViewBrandsBusiness: UITableView?
  
    var brandsData:[BYBBrandsModel]?
    var searchBrandTxt:String?

    override func viewDidLoad(){
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        self.btnFilterBy?.addGradientLayer([kLightGreenColor, kDarkGreenColor],  withDirection: .horizontal)
        if brandsData != nil {
         
            self.showNoDataView(searchText:searchBrandTxt ?? "",brandsCount:brandsData?.count ?? 0,tableViewBrandsBusinessBoolValue:false,noDataViewBoolValue:true)
        }
        else{
       
            self.showNoDataView(searchText:searchBrandTxt ?? "",brandsCount:brandsData?.count ?? 0,tableViewBrandsBusinessBoolValue:true,noDataViewBoolValue:false)
        }
        
        configureCell()
    }

    
    // configure cell identifier
    func configureCell() {
        tableViewBrandsBusiness?.register(UINib(nibName: TableViewCellIdentifier.kBYBBrandsServiceTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifier.kBYBBrandsServiceTableViewCell.rawValue)
        tableViewBrandsBusiness?.separatorStyle = .none
        reloadTableView()
    }
    
    @IBAction func btnActionFilterBy(_ sender: Any) {
        
    }

    // to add action location button
    
    @IBAction func btnActionLocationAddress(_ sender: Any) {
        
    }
    
    @IBAction func btnActionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // hide table View And No data View
    
    func hideBrandTableViewNoData(tableViewBrandsBusinessBoolValue:Bool,noDataViewBoolValue:Bool){
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.noDataView?.isHidden = noDataViewBoolValue
                self.tableViewBrandsBusiness?.isHidden = tableViewBrandsBusinessBoolValue
            })
        }
    }
  
    // show No data View with tabelview search brand text
    func showNoDataView(searchText:String,brandsCount:Int,tableViewBrandsBusinessBoolValue:Bool,noDataViewBoolValue:Bool){
        DispatchQueue.main.async {
            let noDataFoundString  =  kGetBrand + " \(searchText) " +  kPostBrand
            self.noDataFoundLabel?.attributeTextColorChange(fullText: noDataFoundString, changeText: searchText, fontNameText: kBoldAppFont,fontSizeText:12.0)
            let brandCountString =  "\(self.brandsData?.count ?? 0)" + kBrandsFound +  "\"\(searchText)\""
             self.serviceBrandCountLabel?.attributeTextColorChange(fullText: brandCountString, changeText: searchText, fontNameText: kSemiboldAppFont,fontSizeText:12.0)
            
        }; self.hideBrandTableViewNoData(tableViewBrandsBusinessBoolValue:tableViewBrandsBusinessBoolValue,noDataViewBoolValue:noDataViewBoolValue)
        
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.tableViewBrandsBusiness?.reloadData()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        self.view.endEditing(true)
    }
}

// tableView delegate & dataSource
extension BYBBrandSearchResultVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return
            brandsData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.brandsData?[indexPath.row]
        guard  let cell = tableView.dequeueReusableCell(withIdentifier:TableViewCellIdentifier.kBYBBrandsServiceTableViewCell.rawValue) as? BYBBrandsServiceTableViewCell else{
            return UITableViewCell()
        }
        cell.configureCellWithData(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let buyerViewEditProfileVC = BYBBuyerViewEditProfileVC.instantiateWithStoryboard(fromAppStoryboard: .userProfile)
//
//        self.navigationController?.pushViewController(buyerViewEditProfileVC, animated: true)
    }
    
}
