//
//  BYBSearchBrandBusinessVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 06/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

class  BYBSearchBrandBusinessVC: BaseVC,BYBSearchBrandBusinessService{
    var requestService = ServiceRequest()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var noDataFoundLabel: UILabel!
    
    @IBOutlet weak var btnFilterBy: UIButton?
    @IBOutlet weak var btnBrand: UIButton!
    
    @IBOutlet weak var btnBusiness: UIButton!
    
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var viewSearchBrand: UIView!
    @IBOutlet weak var txtLocationAddress: UITextField!
    @IBOutlet weak var tableViewBrandsBusiness: UITableView!
    
    //****** search trough textfield
    
    @IBOutlet weak var txtSearchBrandBusiness: UITextField!
    
    @IBOutlet weak var BrandBussinessSearchCancelButton: UIButton!
    var search:String=""
    var searchBrandsBussinessesDict = [String:Any]()
    
    
    var brandsData:[BYBBrandsModel]?
    var searchActive = false
    
    // user locartion lat long
    
    var userLat = kUserLat
    var userLon = kUserLon
    var searchBrandBusiness = BrandBusinessSearch.kSearchBrand
    var distance = kDistance
    var searchURl = APIURL.SearchBrands
    var checked = false
    var ratingValue = drand48()
    var userDefault = UserDefaults.standard
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        activityIndicator?.isHidden = true;
        self.btnFilterBy?.addGradientLayer([kLightGreenColor, kDarkGreenColor],  withDirection: .horizontal)
        self.noDataView.isHidden = true
        configureCell()
        self.seachBarColorChange()
        txtSearchBrandBusiness.becomeFirstResponder()
        txtSearchBrandBusiness.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                                         for: UIControlEvents.editingChanged)
        BrandBussinessSearchCancelButton.isUserInteractionEnabled = false
        setupUserAddressData()
        
    }
    
    func   setupUserAddressData(){
        guard  let address  =  AppManager.shared().userObj.address?.name else{return}
        txtLocationAddress.text = address
        guard  let lat  =  AppManager.shared().userObj.address?.latitude else{return}
        userLat  = lat
        guard  let lon  =  AppManager.shared().userObj.address?.longitude else{return}
        userLon  = lon
    }
    
    // configure cell identifier
    func configureCell() {
        tableViewBrandsBusiness.register(UINib(nibName: TableViewCellIdentifier.kBYBBrandsServiceTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifier.kBYBBrandsServiceTableViewCell.rawValue)
        tableViewBrandsBusiness.separatorStyle = .none
        reloadTableView()
    }
    
    @IBAction func btnActionFilterBy(_ sender: Any) {
        
    }
    
    @IBAction func btnBrandAction(_ sender: Any) {
        searchURl = APIURL.SearchBrands
    }
    
    @IBAction func btnBusinessAction(_ sender: Any) {
        searchURl = APIURL.SearchBusinesses
        
    }
    
    // to add action location button
    
    @IBAction func btnActionLocationAddress(_ sender: Any) {
        
    }
    
    @IBAction func btnActionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func BrandBussinessSearchCancelButtonAction(_ sender: UIButton)
    {
        if checked {
            txtSearchBrandBusiness.text = ""
            hideBrandTableViewNoData(tableViewBrandsBusinessBoolValue:true,noDataViewBoolValue:true)
            self.brandsData?.removeAll()
            
            sender.setImage(UIImage(named:APPImage.kiconSearchBlack.rawValue), for: .normal)
            BrandBussinessSearchCancelButton.isUserInteractionEnabled = false
            checked = false
        } else {
            BrandBussinessSearchCancelButton.isUserInteractionEnabled = true
            sender.setImage( UIImage(named:APPImage.kIconCrossSearch.rawValue), for: .normal)
            checked = true
        }
        
    }
    
    // hide table View And No data View
    
    func hideBrandTableViewNoData(tableViewBrandsBusinessBoolValue:Bool,noDataViewBoolValue:Bool){
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.noDataView.isHidden = noDataViewBoolValue
                self.tableViewBrandsBusiness.isHidden = tableViewBrandsBusinessBoolValue
            })
        }
    }
    
    // hit brand  Search Api
    func hitSearchBrandsApi(searchText:String,lat:Double,lon:Double,searchURl:String){
        if (Reachability.init()?.isReachable)! {
            self.activityIndicator?.isHidden = false
            self.activityIndicator?.startAnimating();
            let brandURL = searchURl
            let searchBrandDict = ["lat":lat,"lon":lon,"search":searchText,"distance":distance] as [String : Any]
            // requestService.cancel()
            requestService =
                self.searchBrands(url: brandURL,searchBrandsObj:searchBrandDict) { (isSuccess, msg, list, error) in
                    
                    self.activityIndicator?.isHidden = true;
                    self.activityIndicator?.stopAnimating()
                    if isSuccess {
                        self.brandsData = list
                        if (self.brandsData?.count == 0 || self.brandsData == nil){
                            self.showNoDataView(searchText:searchText,tableViewBrandsBusinessBoolValue:true,noDataViewBoolValue:false)
                        }
                        else{
                            self.hideBrandTableViewNoData(tableViewBrandsBusinessBoolValue:false,noDataViewBoolValue:true)
                            self.reloadTableView()
                        }
                        
                    } else {
                        self.showNoDataView(searchText:searchText,tableViewBrandsBusinessBoolValue:true,noDataViewBoolValue:false)
                        
                    }
            }
            
        } else{
            showAlertOnWindow()
        }
        
    }
    
    // show No data View with tabelview search brand text
    func showNoDataView(searchText:String,tableViewBrandsBusinessBoolValue:Bool,noDataViewBoolValue:Bool){
        DispatchQueue.main.async {
            let noDataFoundString  =  kGetBrand + " \(searchText) " +  kPostBrand
            self.noDataFoundLabel?.attributeTextColorChange(fullText: noDataFoundString, changeText: searchText, fontNameText:kBoldAppFont,fontSizeText:12.0)
        }; self.hideBrandTableViewNoData(tableViewBrandsBusinessBoolValue:tableViewBrandsBusinessBoolValue,noDataViewBoolValue:noDataViewBoolValue)
        
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.tableViewBrandsBusiness.reloadData()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        self.view.endEditing(true)
    }
    
    @objc func updateSearchBrandBusines(textField:UITextField)
    {
        if textField == txtSearchBrandBusiness
        {
            guard let brandUpdateSearch = textField.text?.trimmingCharacters(in: .whitespaces)  else{
                return
            }
            if (brandUpdateSearch.isEmpty)
            {
                txtSearchBrandBusiness.text = ""
                self.textFieldDidEndEditing(self.txtSearchBrandBusiness)
                hideBrandTableViewNoData(tableViewBrandsBusinessBoolValue:true,noDataViewBoolValue:true)
                checked = false
                self.BrandBussinessSearchCancelButton.setImage( UIImage(named:APPImage.kiconSearchBlack.rawValue), for: .normal);
                BrandBussinessSearchCancelButton.isUserInteractionEnabled = false;
            }
            else if brandUpdateSearch.count  > 2 {
                hitSearchBrandsApi(searchText:brandUpdateSearch ,lat:userLat,lon:userLon, searchURl: searchURl)
            }
            else{
                self.showNoDataView(searchText:brandUpdateSearch,tableViewBrandsBusinessBoolValue:true,noDataViewBoolValue:true)
            }
        }
        
    }
}


extension BYBSearchBrandBusinessVC:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtLocationAddress {
            didOpenGooglPlacepicker()
            textField.returnKeyType = .done; self.viewLocation?.addViewBorderColorWidth(borderColor:kBorderGreenColor,borderWidth:1.0)
        }
        else if textField == txtSearchBrandBusiness{
            textField.returnKeyType = .search; self.viewSearchBrand?.addViewBorderColorWidth(borderColor:kBorderGreenColor,borderWidth:1.0)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtLocationAddress {
            self.viewLocation?.addViewBorderColorWidth(borderColor:.clear,borderWidth:1.0)
        }
        else if textField == txtSearchBrandBusiness{
            if textField.text?.count == 0 {
                hideBrandTableViewNoData(tableViewBrandsBusinessBoolValue:true,noDataViewBoolValue:true)
            }
            self.viewSearchBrand.addViewBorderColorWidth(borderColor: .clear, borderWidth: 1.0)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        // code for update text
        if textField == txtSearchBrandBusiness{
            delay(delay: 1) {
                self.updateSearchBrandBusines(textField: textField)
            }
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtSearchBrandBusiness{
            if textField.text?.count == 0 {
                hideBrandTableViewNoData(tableViewBrandsBusinessBoolValue:true,noDataViewBoolValue:true)
            }
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let textobj = (textField.text ?? "") as NSString
        let resultString = textobj.replacingCharacters(in: range, with: string)
        
        if (textField.textInputMode?.primaryLanguage == "emoji") || textField.textInputMode?.primaryLanguage == nil {
            return false
        }
        if textField == txtSearchBrandBusiness{
            let brandUpdateBrandSearch = resultString
            if brandUpdateBrandSearch.count  > 0{
                checked = true
                BrandBussinessSearchCancelButton.isUserInteractionEnabled = true; self.BrandBussinessSearchCancelButton.setImage( UIImage(named:APPImage.kIconCrossSearch.rawValue), for: .normal)
            }
            else{
                print(brandUpdateBrandSearch)
                self.hideBrandTableViewNoData(tableViewBrandsBusinessBoolValue: true, noDataViewBoolValue:true)
            }
        }
        else if textField == txtLocationAddress{
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textField == txtSearchBrandBusiness{
            if let brandSearchText = textField.text{
                if brandSearchText.count > 2{
                    let searchBrandResultVC = BYBBrandSearchResultVC.instantiateWithStoryboard(fromAppStoryboard: .userProfile)
                    searchBrandResultVC.brandsData = self.brandsData
                    searchBrandResultVC.searchBrandTxt = textField.text
                    self.navigationController?.pushViewController(searchBrandResultVC, animated: true)
                }
               
            }
        }
        return true
    }
}
// tableView delegate & dataSource
extension BYBSearchBrandBusinessVC:UITableViewDelegate,UITableViewDataSource{
    
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
        
        let searchBrandResultVC = BYBAddEducationPopupVC.instantiateWithStoryboard(fromAppStoryboard: .userProfile)
      
        self.navigationController?.pushViewController(searchBrandResultVC, animated: true)
    }
    
}

extension  BYBSearchBrandBusinessVC:GooglePlaceManagerDelegate
{
    func didOpenGooglPlacepicker() {
        let placepickerObj = GooglePlaceManager.shared().initializeGooglePlacepicker()
        GooglePlaceManager.shared().delegate = self
        self.present(placepickerObj, animated: true, completion: nil)
    }
    
    //MARK: Googleplace manager delegates
    func didRecieveAddress(address: String?, lat: Double?, lon: Double?) {
        guard let address = address,
            let lat = lat,
            let lon = lon else { return }
        txtLocationAddress.text = address
        userLat = lat
        userLon = lon
        self.txtSearchBrandBusiness.text = ""
        self.brandsData?.removeAll()
        self.noDataView.isHidden = true
        tableViewBrandsBusiness.reloadData()
    }
    
    func didFailToReciveAddress(error: Error?) {
        guard let error = error else { return  }
        
    }
}

