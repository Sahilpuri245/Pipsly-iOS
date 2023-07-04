//
//  Extensions.swift
//  ChatSample
//
//  Created by KiwiTech on 21/12/17.
//  Copyright © 2017 KiwiTech. All rights reserved.
//

import UIKit

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }

    var stringByRemovingExtraWhitespaces: String {
        let components = self.components(separatedBy: .whitespaces).filter { (element) -> Bool in
            return !element.isEmpty
        }
        return components.joined(separator: " ")
    }
}

extension Character {
    func isEmoji() -> Bool {
        return Character(UnicodeScalar(UInt32(0x1d000))!) <= self && self <= Character(UnicodeScalar(UInt32(0x1f77f))!)
            || Character(UnicodeScalar(UInt32(0x2100))!) <= self && self <= Character(UnicodeScalar(UInt32(0x26ff))!)
       || Character(UnicodeScalar(UInt32(0x2100))!) <= self && self <= Character(UnicodeScalar(UInt32(0x26ff))!)
    }
}

extension UIResponder {
    func parentController<T: UIViewController>(of type: T.Type) -> T? {
        guard let next = self.next else {
            return nil
        }
        return (next as? T) ?? next.parentController(of: T.self)
    }
}

extension UIButton {
    override open func awakeFromNib() {
        super.awakeFromNib()
        if self.titleLabel?.font != nil {
            self.titleLabel?.font = UIFont(name: (self.titleLabel?.font.fontName)!, size: (self.titleLabel?.font.pointSize)! * getScreenScaleFactor())
        }
        self.isExclusiveTouch = true
    }
}

extension UITextView {
    override open func awakeFromNib() {
        super.awakeFromNib()
        if self.font != nil {
            self.font = UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! * getScreenScaleFactor())
        }
    }
}

var key: Void?
class UITextFieldAdditions: NSObject {
    var readonly: Bool = false
}

extension UIScreen {
    func isPortrait() -> Bool {
        return self.bounds.width < self.bounds.height
    }
}

extension UITableView {
    /// Check if cell at the specific section and row is visible
    /// - Parameters:
    /// - section: an Int reprenseting a UITableView section
    /// - row: and Int representing a UITableView row
    /// - Returns: True if cell at section and row is visible, False otherwise
    func isCellVisible(section: Int, row: Int) -> Bool {
        let indexes = self.indexPathsForVisibleRows!
        return indexes.contains {$0.section == section && $0.row == row }
    }
}

extension Data {
    mutating func append(_ string: String) {
        let data = string.data(
            using: String.Encoding.utf8,
            allowLossyConversion: true)
        append(data!)
    }

    func hex(separator: String = "") -> String {
        return (self.map { String(format: "%02X", $0) }).joined(separator: separator)
    }
}

extension Dictionary {

    init<S: Sequence>
        (_ seq: S)
        where S.Iterator.Element == Element {
            self.init()
            self.merge(seq: seq)
    }

    mutating func merge<S: Sequence>
        (seq: S)
        where S.Iterator.Element == Element {
            var gen = seq.makeIterator()
            while let (k, v) = gen.next() {
                self[k] = v
            }
    }
}

extension Dictionary {

    /// An immutable version of update. Returns a new dictionary containing self's values and the key/value passed in.
    func updatedValue(_ value: AnyObject, forKey key: String) -> Dictionary<String, AnyObject> {
        if var result = self as? Dictionary<String, AnyObject> {
            result[key] = value
            return result
        } else {
            return Dictionary<String, AnyObject>()
        }
    }

    var nullsRemoved: Dictionary<String, AnyObject> {
        if var dict = self as? Dictionary<String, AnyObject> {
            let keysToRemove = dict.keys.filter { dict[$0] is NSNull }
            let keysToremove1 = dict.keys.filter { dict[$0] as? String == "<null>" }

            let keysToCheck = dict.keys.filter { dict[$0] is Dictionary }

            for key in keysToRemove {
                dict.removeValue(forKey: key)
            }

            for key in keysToremove1 {
                dict.removeValue(forKey: key)
            }

            for key in keysToCheck {
                if let subDict = dict[key] as? [Key: AnyObject] {
                    let cleanSubDict = subDict.nullsRemoved
                    dict.updateValue(cleanSubDict as AnyObject, forKey: key)
                }
            }
            return dict
        } else {
            return Dictionary<String, AnyObject>()
        }
    }
}

extension NSTextAttachment {
    func setImageHeight(height: CGFloat) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height
        bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: ratio * height, height: height)
    }
}

extension UITextView {
    func setCursor(position: UITextRange) {
        selectedTextRange = position
        self.scrollRangeToVisible(self.selectedRange)
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Array {
    mutating func removeObject<T>(obj: T) where T: Equatable {
        self = self.filter({$0 as? T != obj})
    }

    func indexOf<T: Equatable>(object: T) -> Int? {
        var result: Int!
        for (index, obj) in self.enumerated() {
            if obj as? T == object {
                result = index
            }
        }
        return result
    }
}

protocol Copyable {
    init(instance: Self)
}

extension Copyable {
    func copy() -> Self {
        return Self.init(instance: self)
    }
}

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}

extension UIDatePicker {
    func setTenYearValidation() {
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        if let timeZome = TimeZone(identifier: "UTC") {
             calendar.timeZone = timeZome
        } else {
            calendar.timeZone = TimeZone.current
        }
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.year = -10
        guard let maxDate = calendar.date(byAdding: components, to: currentDate) else { return }
        self.maximumDate = maxDate
    }
    
}

protocol Jsonable:Codable{}
extension Jsonable {
    func toDictionary() -> [String:Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
            return dict
        } catch {
            return nil
        }
    }
}
