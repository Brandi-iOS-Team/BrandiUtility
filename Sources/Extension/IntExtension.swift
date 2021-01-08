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
    
}
