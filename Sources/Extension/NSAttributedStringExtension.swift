//
//  NSAttributedStringExtension.swift
//  Brandi
//
//  Created by Joongwon Kim on 2020/11/12.
//  Copyright © 2020 Brandi. All rights reserved.
//

import Foundation

public extension NSAttributedString {
    convenience init?(html: String) {
        guard let data = html.data(using: String.Encoding.unicode, allowLossyConversion: false) else {
            return nil
        }
        guard let attributedString = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
            return nil
        }
        self.init(attributedString: attributedString)
    }
}
