//
//  UITableView+Ext.swift
//  ROUTE
//
//  Created by Sumit Tripathi on 17/04/17.
//  Copyright © 2018 Route. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {

    static var NibName: String {
        return String(describing: self)
    }

    static func viewFromNib() -> UIView? {
        let sliderView = Bundle.main.loadNibNamed(NibName, owner: self, options: nil)![0] as? UIView
        return sliderView
    }
}

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func stopFloatingSectionHeader(withHeight height:CGFloat = 100)
    {
        let dummyViewHeight: CGFloat = height
        let dummyView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(self.bounds.size.width), height: dummyViewHeight))
        self.tableHeaderView = dummyView
        contentInset = UIEdgeInsetsMake(-dummyViewHeight, 0, 0, 0)
    }
}

extension UITableView {

    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let Nib = UINib(nibName: T.NibName, bundle: nil)
        register(Nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func register(reuseIdentifier: String) {
        let Nib = UINib(nibName: reuseIdentifier, bundle: nil)
        register(Nib, forCellReuseIdentifier: reuseIdentifier)
    }

}

extension UICollectionView {

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UICollectionView {

    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let Nib = UINib(nibName: T.NibName, bundle: nil)
        register(Nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func registerHeader<T: UICollectionReusableView>(_: T.Type, type : String) where T: ReusableView, T: NibLoadableView {

        let Nib = UINib(nibName: T.NibName, bundle: nil)
        register(Nib, forSupplementaryViewOfKind: type, withReuseIdentifier: T.reuseIdentifier)
    }
}
