//
//  ShowsAlert+Ext.swift
//  PIPSLY
//
//  Created by KiwiTech on 20/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

public extension UIAlertController {
    func showAletOnWindow() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindowLevelAlert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}

protocol ShowsAlert {}

extension ShowsAlert where Self: UIViewController {
    
    
    func showAlert(title: String = kAppName, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertOnWindow(title: String = kAppName, message: String = CommonString.noInternetDescription.rawValue) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alertController.showAletOnWindow()
    }
    
    func showAlertViewOnViewController(viewController: UIViewController, showAlerTitle title: String?, showAlerMessage message: String?, withOptionsButton optionButton: [String], buttonType: [UIAlertActionStyle]? = nil, callBack:@escaping (_ selectedTitle: String, _ selectedIndex: NSInteger) -> Void) {
        
        if message == kCancelledMsg {
            return
        }
        
        if objc_getClass("UIAlertController") != nil {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            for (index, action) in optionButton.enumerated() {
                var type = UIAlertActionStyle.default
                if let types = buttonType, types.count > index {
                    type = types[index]
                }
                let defaultAction = UIAlertAction(title: action, style: type, handler: { _ in
                    let index: NSInteger = optionButton.index(of: action)!
                    callBack(action, index)
                })
                alert.addAction(defaultAction)
            }
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlertViewController(viewController: UIViewController, withAlertTitle title: String?, withAlertMessage message: String?) {
        if message == kCancelledMsg {
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (_: UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}

