//
//  GooglePlaceManager.swift
//  PIPSLY
//
//  Created by KiwiTech on 22/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
import GooglePlacePicker

protocol GooglePlaceManagerDelegate:class {
    func didRecieveAddress(address:String?,lat:Double?,lon:Double?)
    func didFailToReciveAddress(error:Error?)
}

class GooglePlaceManager: NSObject , GMSPlacePickerViewControllerDelegate {

    weak var delegate: GooglePlaceManagerDelegate?

    fileprivate static var sharedObj: GooglePlaceManager = GooglePlaceManager()
    private override init() {
        super.init()
    }
    
    class func shared() -> GooglePlaceManager {
        return sharedObj
    }
    
    func initializeGooglePlacepicker() -> GMSPlacePickerViewController  {
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        placePicker.modalPresentationStyle = .popover
        return placePicker
    }
    
    // MARK: Placepicker Delegate methods
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Create the next view controller we are going to display and present it.
        var address = ""
        var lat: Double?
        var long: Double?
        var namev:String?

        lat = place.coordinate.latitude
        long = place.coordinate.longitude
        namev = place.name
        
        if let formatAdd = place.formattedAddress {
            if let name = namev {
                if formatAdd.range(of:name) == nil {
                    address = "\(name)," + formatAdd
                }else{
                    address = formatAdd
                }
            }else{
                address = formatAdd
            }
        }
        delegate?.didRecieveAddress(address: address, lat: lat, lon: long)
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didFailWithError error: Error) {
        NSLog("An error occurred while picking a place: \(error)")
        delegate?.didFailToReciveAddress(error: error)
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker.
        NSLog("The place picker was canceled by the user")
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
