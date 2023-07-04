//
//  CommonGlobalMethods.swift
//  ROUTE
//
//  Created by kiwitech on 2/15/18.
//  Copyright © 2018 kiwitech. All rights reserved.
//

import Foundation
import UIKit

func print_debug<T>(_ object : T) {
    #if DEBUG
        print(object)
    #endif
}

// get Index Path Array
func getIndexPathArray(_ withSection: Int, withNumberOfIndex: Int) -> [IndexPath] {
    var array = [IndexPath]()
    for i in 0..<withNumberOfIndex {
        array.append(IndexPath(row: i, section: withSection))
    }
    return array
}

// global method for delay
func delay(delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}

// global method to get error obj
func getErrorObj(_ withString: String?, code: Int32 = 8888) -> NSError? {
    let userInfo: [AnyHashable: Any] = [
        NSLocalizedDescriptionKey: NSLocalizedString(kError, value: withString ?? CommonString.noInternetDescription.rawValue, comment: "")
        ]
    let errorFinal: NSError  = NSError.init(domain: "", code: 8888, userInfo: userInfo as? [String: Any])
    return errorFinal
}

// global method to  Path
func getDirectoryPath() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

