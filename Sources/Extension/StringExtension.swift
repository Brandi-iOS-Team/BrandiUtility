//
//  StringExtension.swift
//  Brandi
//
//  Created by Ryan Lee on 2017. 9. 18..
//  Copyright © 2017년 Brandi. All rights reserved.
//

import Foundation
import UIKit

var expressions = [String: NSRegularExpression]()

public extension String {
    func match(regex: String) -> (String, CountableRange<Int>)? {
        let expression: NSRegularExpression
        if let exists = expressions[regex] {
            expression = exists
        } else {
            do {
                expression = try NSRegularExpression(pattern: "^\(regex)", options: [])
                expressions[regex] = expression
            } catch {
                return nil
            }
        }
        
        let range = expression.rangeOfFirstMatch(in: self, options: [], range: NSRange(0 ..< self.utf16.count))
        if range.location != NSNotFound {
            return ((self as NSString).substring(with: range), range.location ..< range.location + range.length )
        }
        return nil
    }
    
    func convertHtml() -> NSMutableAttributedString {
        guard let data = data(using: .utf8) else { return NSMutableAttributedString() }
        do {
            return try NSMutableAttributedString(data: data, options: [NSMutableAttributedString.DocumentReadingOptionKey.documentType: NSMutableAttributedString.DocumentType.html, NSMutableAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSMutableAttributedString()
        }
    }
    
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
                data: data,
                options: [NSMutableAttributedString.DocumentReadingOptionKey.documentType: NSMutableAttributedString.DocumentType.html, NSMutableAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf16.rawValue],
                documentAttributes: nil) else { return nil }
        return html
    }
    
    func formatToDividedAlphabetUnit() -> String {
        guard let intString = Int(self) else { return "0" }
        
        var countString = self
        if intString > 999_999 {
            let count: CGFloat = CGFloat(intString) / 1_000_000
            countString = String(format: "%.1f", count) + "m"
        } else if intString > 999 {
            let count: CGFloat = CGFloat(intString) / 1_000
            countString = String(format: "%.1f", count) + "k"
        }
        return countString
    }
    
    /*
     trim String to remove spaces and other similar symbols (new lines and tabs)
     
     Usage
     
     var str1 = "  a b c d e   \n"
     var str2 = str1.trimmed
     str1.trim()
     
     */
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    mutating func trim() {
        self = self.trimmed
    }
    
    func toDate(format: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.date(from: self)
    }
    
    /*
     For simple platform-independent styling for texts.
     
     Usage
     
     let htmlString = "<p>Hello, <strong>world!</string></p>"
     let attrString = htmlString.asAttributedString
     */
    var asAttributedString: NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
    }
    
    func toTime() -> String {
        guard let leftTime: Int = Int(self) else { return "00:00:00" }
        var hhString = "00"
        var mmString = "00"
        var ssString = "00"
        let ssInt: Int = Int(leftTime % 60)
        let mmInt: Int = Int(leftTime / 60 % 60)
        let hhInt: Int = Int(leftTime / 60 / 60)
        hhString = "\(hhInt)"
        mmString = "\(mmInt)"
        ssString = "\(ssInt)"
        if hhString.count < 2 {
            hhString = "0".appending(hhString)
        }
        if mmString.count < 2 {
            mmString = "0".appending(mmString)
        }
        if ssString.count < 2 {
            ssString = "0".appending(ssString)
        }
        let timeString: String = hhString.appending(":").appending(mmString).appending(":").appending(ssString)
        return timeString
    }
    
    func format(_ format: String) -> String? {
        if let time = TimeInterval(self) {
            let date = Date(timeIntervalSince1970: time)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    func toDigitsOnly() -> String {
        let trim = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return trim
    }
    
    var withoutSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.symbols).joined(separator: "")
    }
    
    func toCallNumberparsed() -> (numHead: String, numBody: String, numTail: String)? {
        let distString = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let startIndex = distString.startIndex
        var head: Substring = ""
        var body: Substring = ""
        var tail: Substring = ""
        
        head = distString[..<distString.index(startIndex, offsetBy: distString.count > 3 ? 3 : distString.count)]
        if distString.count > 3 {
            if distString.count < 11 {
                body = distString[distString.index(startIndex, offsetBy: 3)..<distString.index(startIndex, offsetBy: distString.count > 6 ? 6 : distString.count)]
                if distString.count > 6 {
                    tail = distString[distString.index(startIndex, offsetBy: 6)...]
                }
            } else if distString.count < 12 {
                body = distString[distString.index(startIndex, offsetBy: 3)..<distString.index(startIndex, offsetBy: distString.count > 7 ? 7 : distString.count)]
                if distString.count > 7 {
                    tail = distString[distString.index(startIndex, offsetBy: 7)...]
                }
            }
        }
        return (numHead: String(head), numBody: String(body), numTail: String(tail))
    }
    
    func validateRegex(with regex: String) -> Bool {
        let regex = NSRegularExpression(regex)
        return regex.matches(self)
    }
    
    // MARK: - Emoji
    var isSingleEmoji: Bool { count == 1 && containsEmoji }

    var containsEmoji: Bool { contains { $0.isEmoji } }

    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }

    var emojiString: String { emojis.map { String($0) }.reduce("", +) }

    var emojis: [Character] { filter { $0.isEmoji } }

    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
}
