//
//  BYBAreaInterestVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 05/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
let kProceedDefaultXConstraint:CGFloat = -88
let kProceedDefaultConstraint:CGFloat = -54
let kProceedUpdateConstraint:CGFloat = 20
let kDefaultTitle = "Thank you for creating a Pipsly account."
let kMsg = "You can choose your areas of interest so we could search for the appropriate service providers around you to connect with."

class BYBAreaInterestVC: BaseVC,AreaInterestHeaderDelegate,TagViewCellDelegate,OptionsPopDelegate,BYBSignupService {
    
    @IBOutlet weak var tblView: UITableView?
    @IBOutlet weak var btnProceed: UIButton?
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint?
    var isShowCategories:Bool = true
    var arrSelectedCategories = [Int]()
    var arrCategories:[InterestCategoryModel]?
    var headerObj:AreaInterestHeaderModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: Private methods
    private func setupView() {
        let headerNib = UINib.init(nibName: "AreaInterestHeader", bundle: Bundle.main)
        tblView?.register(headerNib, forHeaderFooterViewReuseIdentifier: "AreaInterestHeader")
        self.tblView?.register(TagViewCell.self)
        self.tblView?.estimatedRowHeight = 100
        self.tblView?.sectionHeaderHeight = 250.0
        self.tblView?.stopFloatingSectionHeader(withHeight: 250)
        self.bottomConstraint?.constant = DeviceType.IS_IPHONE_X ? kProceedDefaultXConstraint : kProceedDefaultConstraint
        getCategories()
        let title = "Hi " + "\(AppManager.shared().userObj.name?.capitalizingFirstLetter() ?? "")! " + kDefaultTitle
        headerObj = AreaInterestHeaderModel(profileImg: nil, title: title, msg: kMsg, isShow: false)
    }
    
    //MARK: OptionsPopup Delegates
    func didSelectCamera() {
        self.view.layoutIfNeeded()
        openCamera()
    }
    
    func didSelectGallery() {
        openLibrary()
    }
    
    func didSelectRemovePhoto() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        if self.headerObj?.profileImage != nil {
            alert.addAction(UIAlertAction(title: kDeletePhoto, style: UIAlertActionStyle.destructive, handler: { (_)in
                self.deletePhoto()
            }))
        }
        alert.addAction(UIAlertAction(title: kCancel, style: UIAlertActionStyle.cancel, handler: { (_)in
        }))
        alert.showAletOnWindow()
    }
    
    //MARK: AreaInterest Delegates
    func didSelectTags(selectedTags: [Int]?, isProceed: Bool) {
        if isProceed {
            UIView.animate(withDuration: Double(0.3), animations: {
                self.bottomConstraint?.constant = CGFloat(kProceedUpdateConstraint)
                self.view.layoutIfNeeded()
            })
        } else {
            UIView.animate(withDuration: Double(0.3), animations: {
                self.bottomConstraint?.constant = DeviceType.IS_IPHONE_X ? kProceedDefaultXConstraint : kProceedDefaultConstraint
                self.view.layoutIfNeeded()
            })
        }
        guard let arrTags = selectedTags else {return}
        arrSelectedCategories = arrTags
    }
    
    func didSelectUpdateProfile() {
        if (Reachability.init()?.isReachable)! {
             openImagePicker()
        } else {
            self.showAlertOnWindow()
        }
    }
    
    func openImagePicker() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        if self.headerObj?.profileImage != nil  {
            alert.addAction(UIAlertAction(title: kDeletePhoto, style: UIAlertActionStyle.destructive, handler: { (_)in
                self.deletePhoto()
            }))
        }
        alert.addAction(UIAlertAction(title: kTakePhoto, style: .default, handler: { (_)in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: kChoosePhoto, style: .default, handler: { (_)in
            self.openLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: kCancel, style: UIAlertActionStyle.cancel, handler: { (_)in
        }))
        alert.showAletOnWindow()
    }
    
    private func openCamera() {
        let cameraViewController = CameraViewController(croppingEnabled: true, allowsLibraryAccess: true, useImage: false) { [weak self] userImage, _ in
            if let image = userImage {
                self?.headerObj?.profileImage = image
                self?.headerObj?.showIndicator = true
                self?.tblView?.reloadData()
                self?.requestToUploadProfileImage()
            }
            self?.dismiss(animated: true, completion: nil)
        }
        present(cameraViewController, animated: true, completion: nil)
    }
    
    private func openLibrary() {
        let libraryViewController = CameraViewController.imagePickerViewController(croppingEnabled: true) { [weak self] userImage, _ in
            if let image = userImage {
                self?.headerObj?.profileImage = image
                self?.headerObj?.showIndicator = true
                self?.tblView?.reloadData()
                self?.requestToUploadProfileImage()
            }
            self?.dismiss(animated: true, completion: nil)
        }
        present(libraryViewController, animated: true, completion: nil)
    }
    
    func deletePhoto() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: kDeletePhoto, style: UIAlertActionStyle.destructive, handler: { (_)in
            self.headerObj?.profileImage = nil
            self.headerObj?.showIndicator = true
            self.tblView?.reloadData()
            self.requestToUploadProfileImage()
        }))
        alert.addAction(UIAlertAction(title: kCancel, style: UIAlertActionStyle.cancel, handler: { (_)in
        }))
        alert.showAletOnWindow()
    }
    
    //MARK: IBAction methods
    @IBAction func tapProceed(_ sender: UIButton) {
        if (Reachability.init()?.isReachable)! {
            Utility.showLoader()
            self.selectCategories(arrSelectedCategories) { (isSuccess, msg, error) in
                Utility.dismissLoader()
                if isSuccess {
                    let topBrandVC = BYBTopBrandsVC.instantiateWithStoryboard(fromAppStoryboard: .login)
                    self.navigationController?.pushViewController(topBrandVC, animated: true)
                }else {
                    self.showAlertViewController(viewController: self, withAlertTitle: kAppName, withAlertMessage: msg)
                }
            }
        } else {
            self.showAlertOnWindow()
        }
    }
    
    @IBAction func tapLater(_ sender: UIButton) {
        let dashboardVC = BYBDashboardVC.instantiateWithStoryboard(fromAppStoryboard: .userProfile)
        self.navigationController?.pushViewController(dashboardVC, animated: true)
    }
    
    //MARK: API Calls
    func getCategories() {
        if (Reachability.init()?.isReachable)! {
            Utility.showLoader()
            self.categories(completion: { (isSuccess,msg,list,error) -> Void in
                Utility.dismissLoader()
                if isSuccess {
                    self.arrCategories = list
                    self.tblView?.reloadData()
                    delay(delay: 1, closure: {
                        self.isShowCategories = false
                    })
                } else {
                    self.showAlertViewController(viewController: self, withAlertTitle: kAppName, withAlertMessage: msg)
                }
            })
        } else {
            self.showAlertOnWindow()
        }
    }
    
    func requestToUploadProfileImage()  {
        self.uploadProfileImage(imageData: self.headerObj?.imageData) { (isSuccess, profileUrl,msg, error) in
            if isSuccess {
                self.headerObj?.showIndicator = false
                Utility.showToastMessage(msg ?? "")
                self.tblView?.reloadData()
                
            } else {

            }
        }
    }

}


