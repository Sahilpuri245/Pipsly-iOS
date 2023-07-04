//
//  Loader.swift
//  ROUTE
//
//  Created by kiwitech on 28/04/17.
//  Copyright © 2017 KiwiTech. All rights reserved.
//

import UIKit

class Loader: NSObject {
    static let loaderRadius: CGFloat = 50
    static let loaderColor = UIColor.init(red: 0.0, green: 230.0/255.0, blue: 0.0, alpha: 1.0)
    static let loaderBgColor = UIColor.clear
    static let baseView: UIView = UIView()
    static let baseLoadingView: UIView = UIView()
    static var activityIndicatorView: NVActivityIndicatorView!

    class func addLoader(_ view: UIView, loaderColor: UIColor) {
        self.removeLoader() // removal of activity indicator before adding to base view, check if already added to base view
        baseView.backgroundColor = UIColor.clear
        baseView.frame = view.frame
        let frame = CGRect(x: (view.frame.size.width-loaderRadius)/2, y: (view.frame.size.height-loaderRadius)/2, width: loaderRadius, height: loaderRadius)
        activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                        type: .lineScale, color: Loader.loaderColor, padding: 0)
        baseLoadingView.frame = activityIndicatorView.frame
        baseLoadingView.layer.cornerRadius = loaderRadius/2
        baseLoadingView.layer.borderWidth = 0
        baseLoadingView.layer.borderColor = Loader.loaderBgColor.cgColor
        baseLoadingView.backgroundColor = Loader.loaderBgColor
        baseView.addSubview(baseLoadingView)
        baseView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        view.addSubview(baseView)
    }
    class func addLoader(_ view: UIView, loaderColor: UIColor, withYAxisHeight height: CGFloat, loaderInMiddle: Bool = false) {
        self.removeLoader() // removal of activity indicator before adding to base view, check if already added to base view
        baseView.backgroundColor = UIColor.clear
        let calculatedBaseViewFrame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y + height, width: view.frame.size.width, height: view.frame.size.height - height)
        baseView.frame = calculatedBaseViewFrame
        let frame = CGRect(x: (baseView.frame.size.width-loaderRadius)/2, y: loaderInMiddle == false ?(baseView.frame.size.height-loaderRadius)/2 : (baseView.frame.size.height-(height/2)-loaderRadius)/2, width: loaderRadius, height: loaderRadius)
        activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                        type: .lineScale, color: Loader.loaderColor, padding: 0)
        baseLoadingView.frame = activityIndicatorView.frame
        baseLoadingView.layer.cornerRadius = loaderRadius/2
        baseLoadingView.layer.borderWidth = 0
        baseLoadingView.layer.borderColor = Loader.loaderBgColor.cgColor
        baseLoadingView.backgroundColor = Loader.loaderBgColor
        baseView.addSubview(baseLoadingView)
        baseView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        view.addSubview(baseView)
    }

    class func removeLoader() {
        if activityIndicatorView != nil {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.removeFromSuperview()
            baseView.removeFromSuperview()
        }
    }
}

class InstanceLoader: NSObject {

    let loaderRadius: CGFloat = 50
    let baseView: UIView = UIView()
    let baseLoadingView: UIView = UIView()
    var activityIndicatorView: NVActivityIndicatorView!
    var isRunning: Bool!

    func addLoader(_ view: UIView, loaderColor: UIColor) {

        self.removeLoader() // removal of activity indicator before adding to base view, check if already added to base view
        self.isRunning = true
        baseView.backgroundColor = UIColor.clear
        baseView.frame = view.frame
        let frame = CGRect(x: (view.frame.size.width-loaderRadius)/2, y: (view.frame.size.height-loaderRadius)/2, width: loaderRadius, height: loaderRadius)
        activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                        type: .lineScale, color: Loader.loaderColor, padding: 0)
        baseLoadingView.frame = activityIndicatorView.frame
        baseLoadingView.layer.cornerRadius = loaderRadius/2
        baseLoadingView.layer.borderWidth = 0
        baseLoadingView.layer.borderColor = Loader.loaderBgColor.cgColor
        baseLoadingView.backgroundColor = Loader.loaderBgColor
        baseView.addSubview(baseLoadingView)
        baseView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        view.addSubview(baseView)
    }

    func addLoader(_ view: UIView, loaderColor: UIColor, withYAxisHeight yOffset: CGFloat) {
        self.removeLoader() // removal of activity indicator before adding to base view, check if already added to base view
        self.isRunning = true
        var rect: CGRect = view.frame
        rect.origin.y = yOffset
        rect.size.height = rect.size.height - yOffset
        baseView.frame = rect
        baseView.backgroundColor = UIColor.clear
        let frame = CGRect(x: (view.frame.size.width-loaderRadius)/2, y: (view.frame.size.height-loaderRadius)/2-yOffset, width: loaderRadius, height: loaderRadius)
        activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                        type: .lineScale, color: Loader.loaderColor, padding: 0)
        baseLoadingView.frame = activityIndicatorView.frame
        baseLoadingView.layer.cornerRadius = loaderRadius/2
        baseLoadingView.layer.borderWidth = 0
        baseLoadingView.layer.borderColor = Loader.loaderBgColor.cgColor
        baseLoadingView.backgroundColor = Loader.loaderBgColor
        baseView.addSubview(baseLoadingView)
        baseView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        view.addSubview(baseView)
    }

     func removeLoader() {
        if activityIndicatorView != nil {
            self.isRunning = false
            activityIndicatorView.stopAnimating()
            activityIndicatorView.removeFromSuperview()
            baseView.removeFromSuperview()
        }
    }
}
