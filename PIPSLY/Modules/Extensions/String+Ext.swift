//
//  String+Ext.swift
//  ROUTE
//
//  Created by Sumit Tripathi on 18/07/17.
//  Copyright © 2017 KiwiTech. All rights reserved.
//

import UIKit

extension String {
    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    func isAlphanumeric() -> Bool {
        return self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil && self != ""
    }
    var doubleValue: Double? {
        return Double(self)
    }
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }

    func isYouTubeUrl() -> Bool {
        let regularExpression = "^((?:https?:)?\\/\\/)?((?:www|m)\\.)?((?:youtube\\.com|youtu.be))(\\/(?:[\\w\\-]+\\?v=|embed\\/|v\\/)?)([\\w\\-]+)(\\S+)?$"
        let passwordValidation = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return passwordValidation.evaluate(with: self)
    }

    func isValidURLink() -> Bool {
        let urlString = self
        if let url  = NSURL(string: urlString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }

    func getValidLink() -> String? {
        let input = self
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector?.matches(in: input, options: [], range: NSRange(location: 0, length: input.count))
        var url: String? = nil
        if let matcArr = matches {
            for match in matcArr {
                url = (input as NSString).substring(with: match.range)
                print(url ?? "")
                break
            }
        }
        return url
    }
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    private static var numbersSet = CharacterSet(charactersIn: "1234567890")
    private static var alphabetSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ")

    func isValidPassword() -> Bool {
        return 6...15 ~= characters.count &&
            rangeOfCharacter(from: String.numbersSet) != nil &&
            rangeOfCharacter(from: String.alphabetSet) != nil
    }

    func isEmoji() -> Bool {
        for i in self {
            if i.isEmoji() {
                return true
            }
        }
        return false
    }
    var containsWhitespace: Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    var containsEmoji: Bool {
        for scalar in unicodeScalars {

            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x1F1E6...0x1F1FF, // Regional country flags
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F,   // Variation Selectors
            0x1F900...0x1F9FF,  // Supplemental Symbols and Pictographs
            65024...65039, // Variation selector
            8400...8447: // Combining Diacritical Marks for Symbols
                return true

            default:
                continue
            }
        }
        return false
    }

    var validNameChar: Bool {
        let characterSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ")
        let range = (self as NSString).rangeOfCharacter(from: characterSet)
        return range.location != NSNotFound
    }

    var validUserNameChar: Bool {
        let characterSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890")
        let range = (self as NSString).rangeOfCharacter(from: characterSet)
        return range.location != NSNotFound
    }

    var validCompanyNameChar: Bool {
        let characterSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890 ")
        let range = (self as NSString).rangeOfCharacter(from: characterSet)
        return range.location != NSNotFound
    }

    mutating func trim() {
        self = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    func slice(from: String, to: String) -> String? {

        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)

        return boundingBox.height
    }

    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)

        return boundingBox.width
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return boundingBox.height
    }

    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return boundingBox.width
    }

}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    var containsNonWhitespace: Bool {
        return !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

}
