//
//  NSRegularExpressionExtend.swift
//  Brandi
//
//  Created by JHK on 20. 03. 11..
//  Copyright © 2020 Brandi. All rights reserved.
//

import Foundation

public extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
    
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
