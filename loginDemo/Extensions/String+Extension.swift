//
//  StringExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

//Static EmailRegex
let kEmailRegex = "(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*)@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?)"


let passportNoRegex = "^[A-PR-WYa-pr-wy][1-9]\\d\\s?\\d{4}[1-9]$"//"^([A-Z]){1}([0-9]){8}$"
let drivingLicenseNoRegex = "^([a-zA-Z]){2}([0-9]){2}([0-9]){4}([0-9]){7}$" //"^([0-9a-zA-Z]){15}$"
let voterIdCardNoRegex = "^([a-zA-Z]){3}([0-9]){7}$"
let panCardNoRegex = "^([A-Z]){5}([0-9]){4}([A-Z]){1}$"
let aadharCardNoRegex = "^[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}$"
let rationCardNoRegex = "^([a-zA-Z0-9]){8,16}\\s*$"

extension String {
    var firstUppercased: String
    {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    
    static func isNull(aString: Any?) -> Bool
    {
        //Check for null
        if(aString is NSNull)
        {
            return true
        }
        
        if(aString == nil)
        {
            return true
        }
        
        let x: Any? = aString
        
        //if string is nsnumber , convert it into string and check
        if (aString is NSNumber)
        {
            var aString1 : String? = ""
            aString1 = String(describing: aString)
            return aString1!.isEmptyString
        }
        
        if let aString1 = x as? String
        {
            return aString1.isEmptyString
        }
        else
        {
            return true
        }
    }
}

extension String
{
    //MARK:- Validation Functions
    //Length validation
    var isEmptyString: Bool {
        return trimming_WS_NL.count == 0
    }
    
    var isValidUrl: Bool {
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with: self)
    }
    
    var isValidPanCard : Bool {
        let regEx = "^([A-Z]){5}([0-9]){4}([A-Z]){1}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with: self)
    }
    
    var isValidPassport: Bool {
        let passportRegEx = passportNoRegex
        let passportTest = NSPredicate(format: "SELF MATCHES %@", passportRegEx)
        return passportTest.evaluate(with: self)
    }
    
    
    func checkValidWith(regex: String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray: [regex])
        return predicate.evaluate(with: self)
    }
    
    
    var isValidEmail: Bool {
        let emailRegEx = kEmailRegex
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        // least one uppercase,
        // least one digit
        // least one special character
        //  min 8 characters total
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)
    }
    
    var isValidVoterID: Bool {
        let emailRegEx = voterIdCardNoRegex
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

extension String
{
    var condensedWhitespace: String
    {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var length: Int
    {
        return self.count
    }
    
    subscript (i: Int) -> String
    {
        return self[i ..< (i + 1)]
    }
    
    func substring(from: Int) -> String
    {
        return self[min(from, length) ..< length]
    }
    
    func substring(to: Int) -> String
    {
        return self[0 ..< max(0, to)]
    }
    
    subscript (r: Range<Int>) -> String
    {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        let tempRange = start..<end
        return String(self[tempRange])
    }
}

extension String
{
    func index(from: Int) -> Index
    {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(with r: Range<Int>) -> String
    {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}


extension RangeExpression where Bound == String.Index  {
    func nsRange<S: StringProtocol>(in string: S) -> NSRange { .init(self, in: string) }
}


extension StringProtocol {
    func nsRange<S: StringProtocol>(of string: S, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> NSRange? {
        self.range(of: string,
                   options: options,
                   range: range ?? startIndex..<endIndex,
                   locale: locale ?? .current)?
            .nsRange(in: self)
    }
    func nsRanges<S: StringProtocol>(of string: S, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> [NSRange] {
        var start = range?.lowerBound ?? startIndex
        let end = range?.upperBound ?? endIndex
        var ranges: [NSRange] = []
        while start < end,
            let range = self.range(of: string,
                                   options: options,
                                   range: start..<end,
                                   locale: locale ?? .current) {
            ranges.append(range.nsRange(in: self))
            start = range.lowerBound < range.upperBound ? range.upperBound :
            index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return ranges
    }
}



extension String
{
    //MARK:- HTML content decoded string
    func getDecodedString(withfont: UIFont) -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        guard let attributedString = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.characterEncoding : String.Encoding.utf8.rawValue,
            NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil) else {
            return nil
        }
        attributedString.addAttributes([NSAttributedString.Key.font : withfont], range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    

    var attributedHtmlString: NSAttributedString? {
        
        guard let utf8Data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        
        do {
            return try NSAttributedString(data: utf8Data, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil)
        } catch let er {
            print("Error:", er)
            return nil
        }
    }
    
    
    var getHtmlToString : String {
        
        guard let data = self.data(using: .utf8) else {
            return self
        }
        guard let attributedString = try? NSMutableAttributedString(data: data, options: [ NSAttributedString.DocumentReadingOptionKey.characterEncoding : String.Encoding.utf8.rawValue,
                                                                                          
            NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil) else {
            return self
        }
        return attributedString.string
    }
    
    func mutableParagraphAttributedString(font: UIFont = .boldSystemFont(withSize: .value) , textColor: UIColor = UIColor.customBlack.withAlphaComponent(0.6), lineSpacing:CGFloat,alignment: NSTextAlignment = .natural) -> NSMutableAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineSpacing = lineSpacing
        return NSMutableAttributedString(string: self,
                                  attributes: [.paragraphStyle : paragraphStyle,
                                               .font : font,
                                               .foregroundColor : textColor])
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
}


extension String {
    
    var isStringEmpty : Bool {
        return !(trimming_WS_NL.count > 0)
    }
    
    var nsString : NSString {
        return NSString(string: self)
    }
    
    var trimming_WS_NL : String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var trimming_NL : String {
        return trimmingCharacters(in: .newlines)
    }
    
    var trimming_WS : String {
        return trimmingCharacters(in: .whitespaces)
    }
    
    var is_trimming_WS_NL_to_String : String? {
        return trimming_WS_NL.count > 0 ? self : nil
    }
}

extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"

        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)

        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }

        return (self as NSString).substring(with: result.range)
    }
    
    //at will be only 0-3.
    func youtubeThumbnail(at: Int) -> String {
        return "http://img.youtube.com/vi/\(youtubeID ?? "")/\(at).jpg"
    }
    
    
    var urlQueryAllowed : String {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    var stringToUrl : URL? {
        if let url = URL(string: self.trimming_WS) {
           return url

       } else if let strUrl = self.trimming_WS.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: strUrl) {
           return url
           
       } else {
           return nil
       }
    }
    
    
    static func isStringEmpty(aString: String) -> Bool
    {
        if (aString.length > 0)
        {
            let trimmedString = (aString as NSString).trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            if((trimmedString as NSString).length == 0)
            {
                return true
            }
            else
            {
                return false
            }
        }
        else if ((aString as NSString).length == 0)
        {
            return true
        }
        else
        {
            let trimmedString = (aString as NSString).trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            if ((trimmedString as NSString).length == 0)
            {
                return true
            }
        }
        return false
    }
}


extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}

extension String { // for Swift 4 you need to add the constrain `where Index == String.Index`
    var byWords: [String] {
        var byWords: [String] = []
        
        enumerateSubstrings(in: startIndex..., options: .byWords) { substr, _, _, stop in
            if let word = substr {
                byWords.append(word)
            }
        }
        
        return byWords
    }
}

extension NSString {
    
    var fileNameWithOutExtension: String {
        var fileName = lastPathComponent.replacingOccurrences(of: self.pathExtension, with: "")
        if fileName.last == "." {
            fileName.removeLast()
        }
        return fileName
    }
    
}
extension RangeReplaceableCollection where Element: Hashable {
    var squeezed: Self {
        var set = Set<Element>()
        return filter{ set.insert($0).inserted }
    }
}
extension String {
    func getDate(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self) ?? Date()
    }
}
