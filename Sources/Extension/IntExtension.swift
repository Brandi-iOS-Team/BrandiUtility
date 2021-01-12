//
//  IntExtension.swift
//  Brandi
//
//  Created by NohEunTae on 2020/07/20.
//  Copyright © 2020 Brandi. All rights reserved.
//

import Foundation
import UIKit

public extension Int {
    func decimalFormatted() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) {
            return formattedNumber
        }

        return "\(self)"
    }
    
    func toStringDividedAlphabetUnit() -> String {
        var countString = "\(self)"
        if self > 999_999 {
            let count: CGFloat = CGFloat(self) / 1_000_000
            countString = String(format: "%.1f", count) + "m"
        } else if self > 999 {
            let count: CGFloat = CGFloat(self) / 1_000
            countString = String(format: "%.1f", count) + "k"
        }
        return countString
    }
    
    /*
     Why not use "\(someVar)"? This returns optional.
     Swift will add the word 'optional' to the output.
     So let's handle optionals beautifully.
     */
    func toString() -> String {
        "\(self)"
    }
    
    func toDecimal(suffix: String? = nil) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        var resultString = (nf.string(from: NSNumber(value: self)) ?? "?")
        if let suffix = suffix {
            resultString += suffix
        }
        return resultString
    }
    
    func cgfloat() -> CGFloat {
        return CGFloat(self)
    }
    
    func toTimeStartMinutes() -> String {
        var leftedMinutes: String = String(self / 60)
        var leftedSeconds: String = String(self % 60)
        if leftedMinutes.count == 1 {
            leftedMinutes.insert("0", at: leftedMinutes.startIndex)
        }
        if leftedSeconds.count == 1 {
            leftedSeconds.insert("0", at: leftedSeconds.startIndex)
        }
        return leftedMinutes.appending(":").appending(leftedSeconds)
    }
}
