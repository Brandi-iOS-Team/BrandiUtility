//
//  Date_Extension.swift
//  Hiver
//
//  Created by Joo Hee on 20. 09. 17..
//  Copyright © 2020 Brandi. All rights reserved.
//

import Foundation

public extension Date {
    func formatted(_ format: String? = nil) -> String {
        let validFormat = format ?? "yyyy.MM.dd"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = validFormat
        if let languageID = Locale.preferredLanguages.first {
            dateFormatter.locale = Locale(identifier: languageID)
        }
        return dateFormatter.string(from: self)
    }
}
