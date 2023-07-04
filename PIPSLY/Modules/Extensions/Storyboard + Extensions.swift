//
//  Storyboard + Extensions.swift
//  ProfileSample
//
//  Created by Neelam Yadav on 1/9/18.
//  Copyright © 2018 KiwiTech. All rights reserved.
//

import Foundation
import UIKit

enum StoryBoard: String {

    case main = "Main"
    case login = "Login"
    case dashboard = "Dashboard"
    case userProfile   = "UserProfile"

    var storyboard: UIStoryboard {

        return UIStoryboard(name: self.rawValue, bundle: nil)
    }

    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {

        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID

        guard let scene = storyboard.instantiateViewController(withIdentifier: storyboardID) as? T else {

            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard")
        }

        return scene
    }
}

extension UIViewController {

    class var storyboardID: String {

        return "\(self)"
    }

    static func instantiateWithStoryboard(fromAppStoryboard appStoryboard: StoryBoard) -> Self {

        return appStoryboard.viewController(viewControllerClass: self)
    }

}
