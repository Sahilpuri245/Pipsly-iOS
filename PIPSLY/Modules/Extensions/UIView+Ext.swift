//
//  UIView+Ext.swift
//  ROUTE
//
//  Created by Sumit Tripathi on 18/07/17.
//  Copyright © 2018 Route. All rights reserved.
//

import UIKit

private var activityIndicatorViewAssociativeKey = "ActivityIndicatorViewAssociativeKey"

extension UIView{
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.isExclusiveTouch = true
    }
    
    @discardableResult func addGradientLayer(_ colors: [UIColor], withDirection diretion: GradientDirection) -> CAGradientLayer {
        if let gradientLayer = gradientLayer { return gradientLayer }
        
        let gradient = CAGradientLayer()
        
        gradient.frame = bounds
        if diretion == .horizontal {
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        } else if diretion == .vertical {
            gradient.locations = [0.0, 1.0]
        } else if diretion == .diagnol {
            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        }
        
        gradient.colors = colors.map { $0.cgColor }
        layer.insertSublayer(gradient, at: 0)
        
        return gradient
    }
}


//// to add color and BorderWidth

public extension UIView{
    
    func addViewBorderColorWidth(borderColor:UIColor,borderWidth:CGFloat){
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
}




public extension UIView {

    func disable(_ alpha: CGFloat = 0.5) {
        self.alpha = alpha
        self.isUserInteractionEnabled = false
    }

    func enable() {
        self.alpha = 1.0
        self.isUserInteractionEnabled = true
    }

    func circularView(_ bWidth: CGFloat, color: UIColor) {
        self.layer.borderWidth = bWidth
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }

    func removeGradientLayer() -> CAGradientLayer? {
        gradientLayer?.removeFromSuperlayer()

        return gradientLayer
    }
    func resizeGradientLayer() {
        gradientLayer?.frame = bounds
    }
    fileprivate var gradientLayer: CAGradientLayer? {
        return layer.sublayers?.first as? CAGradientLayer
    }
    func currentFirstResponder() -> UIResponder? {
        if self.isFirstResponder {
            return self
        }
        for view in self.subviews {
            if let responder = view.currentFirstResponder() {
                return responder
            }
        }
        return nil
    }
    public class func instantiateViewFromNib<T>(_ nibName: String, inBundle bundle: Bundle = Bundle.main) -> T? {
        if let objects = bundle.loadNibNamed(nibName, owner: nil) {
            for object in objects {
                if let object = object as? T {
                    return object
                }
            }
        }
        return nil
    }

    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = self.superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }
}

import UIKit

class CopyableLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sharedInit()
    }

    func sharedInit() {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(self.showMenu)))
    }

    @objc func showMenu(sender: AnyObject?) {
        self.becomeFirstResponder()

        let menu = UIMenuController.shared

        if !menu.isMenuVisible {
            menu.setTargetRect(bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }

    override func copy(_ sender: Any?) {
        let board = UIPasteboard.general

        board.string = text

        let menu = UIMenuController.shared

        menu.setMenuVisible(false, animated: true)
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {

        if action == #selector(UIResponderStandardEditActions.copy) {
            return true
        }

        return false
    }
}

public extension UIView {
    var activityIndicatorView: UIActivityIndicatorView {
        get {
            if let activityIndicatorView = getAssociatedObject(&activityIndicatorViewAssociativeKey) as? UIActivityIndicatorView {
                return activityIndicatorView
            } else {
                let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                activityIndicatorView.activityIndicatorViewStyle = .gray
                activityIndicatorView.color = .gray
                activityIndicatorView.center = CGPoint(x: (self.frame.size.width)/2, y: 50)
                activityIndicatorView.hidesWhenStopped = true
                addSubview(activityIndicatorView)

                setAssociatedObject(activityIndicatorView, associativeKey: &activityIndicatorViewAssociativeKey, policy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return activityIndicatorView
            }
        }
        set {
            addSubview(newValue)
            setAssociatedObject(newValue, associativeKey: &activityIndicatorViewAssociativeKey, policy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
extension UISearchBar {

    func setMagnifyingGlassColorTo(color: UIColor) {
        // Search Icon
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = color
    }

    func setClearButtonColorTo(color: UIColor) {
        // Clear Button
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        let crossIconView = textFieldInsideSearchBar?.value(forKey: "clearButton") as? UIButton
        crossIconView?.setImage(crossIconView?.currentImage?.withRenderingMode(.alwaysTemplate), for: .normal)
        crossIconView?.tintColor = color
    }

    func setPlaceholderTextColorTo(color: UIColor) {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = color
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = color

    }

    func change(textFont: UIFont?) {

        for view: UIView in (self.subviews[0]).subviews {
            if let textField = view as? UITextField {
                textField.font = textFont
            }
        }
    }

    func changeBackgroundColor(color: UIColor) {

        for view: UIView in (self.subviews[0]).subviews {
            if let textField = view as? UITextField {
                textField.backgroundColor = color
            }
        }
        self.barTintColor = color
        self.backgroundColor = color
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    
}
