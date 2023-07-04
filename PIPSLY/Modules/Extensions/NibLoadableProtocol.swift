//
//  LoadableViewProtocol.swift
//  PIPSLY
//
//  Created by Kiwitech on 17/01/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

/// Protocol to define family of loadable views
public protocol NibLoadableProtocol: NSObjectProtocol {

    /// View that serves as a container for loadable view. Loadable views are added to container view in `setupNib(_:)` method.
    var nibContainerView: UIView { get }

    /// Method that loads view from single view xib with `nibName`.
    ///
    /// - returns: loaded from xib view
    func loadNib() -> UIView

    /// Method that is used to load and configure loadableView. It is then added to `nibContainerView` as a subview. This view receives constraints of same width and height as container view.
    func setupNib()

    /// Name of .xib file to load view from.
    var nibName: String { get }
}

extension UIView {
    /// View usually serves itself as a default container for loadable views
    @objc dynamic open var nibContainerView: UIView { return self }

    /// Default nibName for all UIViews, equal to name of the class.
    @objc dynamic open var nibName: String { return String(describing: type(of: self)) }
}

extension NibLoadableProtocol {
    /// Method that loads view from single view xib with `nibName`.
    ///
    /// - returns: loaded from xib view
    public func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            return view
        } else {
            return UIView()
        }
    }

    public func setupView(_ view: UIView, inContainer container: UIView) {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .clear
        container.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        container.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: bindings))
        container.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: bindings))
    }
}
