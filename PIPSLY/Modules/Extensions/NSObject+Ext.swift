//
//  NSObject+Ext.swift
//  ROUTE
//
//  Created by Sumit Tripathi on 18/07/17.
//  Copyright © 2017 KiwiTech. All rights reserved.
//

import Foundation
import SDWebImage

extension NSObject {

    func safeValue(forKey key: String) -> Any? {
        let copy = Mirror(reflecting: self)
        for child in copy.children.makeIterator() {
            if let label = child.label, label == key {
                return child.value
            }
        }
        return nil
    }

    func setAssociatedObject(_ value: AnyObject?, associativeKey: UnsafeRawPointer, policy: objc_AssociationPolicy) {
        if let valueAsAnyObject = value {
            objc_setAssociatedObject(self, associativeKey, valueAsAnyObject, policy)
        }
    }

    func getAssociatedObject(_ associativeKey: UnsafeRawPointer) -> Any? {
        guard let valueAsType = objc_getAssociatedObject(self, associativeKey) else {
            return nil
        }
        return valueAsType
    }

    private struct AssociatedKeys {
        static var descriptiveName = "nsh_descriptiveName"
    }

    var associatedObj: SDWebImageOperation? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.descriptiveName) as? SDWebImageOperation
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.descriptiveName,
                    newValue as SDWebImageOperation?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}
