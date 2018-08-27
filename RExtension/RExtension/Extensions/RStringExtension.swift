//
//  RStringExtension.swift
//  RExtension
//
//  Created by rajkumar.sharma on 20/08/18.
//  Copyright © 2018 Raj Sharma. All rights reserved.
//

import UIKit

extension String {
    
    func contains(_ string: String) -> Bool {
        return self.range(of: string) != nil
    }
    
    func substringFromIndex(_ index: Int) -> String {
        if (index < 0 || index > self.count) {
            print("index \(index) out of bounds")
            return ""
        }
        
        let newStr = self[self.index(self.startIndex, offsetBy: index)...]
        return String(newStr)
    }
    
    func substringToIndex(_ index: Int) -> String {
        if (index < 0 || index > self.count) {
            print("index \(index) out of bounds")
            return ""
        }
        
        let newStr = self[..<self.index(self.startIndex, offsetBy: index)]
        return String(newStr)
    }
    
    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        while let range = self.range(of: substring, options: options, range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex, locale: locale) {
            ranges.append(range)
        }
        return ranges
    }
    
    var trimWhiteSpace: String {
        let trimmedString = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        return trimmedString
    }
    
    var length: Int {
        return self.count
    }
    
    var extractNumber: String {
        
        let numbers = self.components(separatedBy: CharacterSet.decimalDigits.inverted)
        let userNumber = numbers.joined(separator: "") // Using space as separator
        
        return userNumber
    }
    
    //>>>> removes all whitespace from a string, not just trailing whitespace <<<//
    
    var removeWhiteSpaces: String {
        return self.replaceString(" ", withString: "")
    }
    
    //>>>> Replacing String with String <<<//
    func replaceString(_ string:String, withString:String) -> String {
        return self.replacingOccurrences(of: string, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func dateFromString(_ format: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            print("Unable to format date")
        }
        
        return nil
    }
    
    func dateFromUTC() -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            print("Unable to format date")
        }
        
        return nil
    }
    
    func stringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
        if let date = dateFormatter.date(from: self) {
            return date
        }
        return nil
    }
    
    func heightWithConstraints(width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func widthWithConstraints(height: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.width
    }
    
    func toJson() -> AnyObject? {
        
        if let data = self.data(using: String.Encoding.utf8) {
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                return json as AnyObject?
            } catch {
                print("Error on Serialization: \(error)")
            }
        }
        
        return nil
    }
    
    func toDictionary() -> [String:AnyObject]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Error on Serialization: \(error)")
            }
        }
        return nil
    }
    
    func jwtTokenInfo() -> Dictionary<String, AnyObject>? {
        
        let segments = self.components(separatedBy: ".")
        
        var base64String = segments[1] as String
        
        if base64String.count % 4 != 0 {
            let padlen = 4 - base64String.count % 4
            base64String += String(repeating: "=", count: padlen)
        }
        
        if let data = Data(base64Encoded: base64String, options: []) {
            do {
                let tokenInfo = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                return tokenInfo as? Dictionary<String, AnyObject>
            } catch {
                print("error to generate jwtTokenInfo >>>>>>  \(error)")
            }
        }
        return nil
    }
    
    var getPathExtension: String {
        return (self as NSString).pathExtension
    }
    
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    /*>>>>>>>>>>>>>>>>>>>>>>>>>>>> Get Attributed String <<<<<<<<<<<<<<<<<<<<<<<<*/
    
    func getAttributedString(_ string_to_Attribute:String, color:UIColor, font:UIFont) -> NSAttributedString {
        
        let range = (self as NSString).range(of: string_to_Attribute)
        
        let attributedString = NSMutableAttributedString(string:self)
        
        // multiple attributes declared at once
        let multipleAttributes = [
            NSAttributedStringKey.foregroundColor: color,
            NSAttributedStringKey.font: font,
            ]
        
        attributedString.addAttributes(multipleAttributes, range: range)
        
        return attributedString.mutableCopy() as! NSAttributedString
    }
    
    func getUnderLinedAttributedString() -> NSAttributedString {
        
        let underlineAttribute = [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]
        let underlineAttributedString = NSAttributedString(string: self, attributes: underlineAttribute)
        
        return underlineAttributedString
    }
    
    subscript(r: Range<Int>) -> String? {
        get {
            let stringCount = self.count as Int
            if (stringCount < r.upperBound) || (stringCount < r.lowerBound) {
                return nil
            }
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound - r.lowerBound)
            return String(self[(startIndex ..< endIndex)])
        }
    }
    
    func containsAlphabets() -> Bool {
        //Checks if all the characters inside the string are alphabets
        let set = CharacterSet.letters
        return self.utf16.contains( where: {
            guard let unicode = UnicodeScalar($0) else { return false }
            return set.contains(unicode)
        })
    }
    
    func boolValue() -> Bool {
        
        var boolValue = false
        
        if self == "true" || self == "1" || self == "yes" || self == "YES" || self == "TRUE" {
            boolValue = true
        }
        return boolValue
    }
    
    func openAsURL() {
        if let url = URL(string: self) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
