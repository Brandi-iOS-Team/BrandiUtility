//
//  RawRepresentable.swift
//  Brandi
//
//  Created by NohEunTae on 2020/08/11.
//  Copyright © 2020 Brandi. All rights reserved.
//

import Foundation

public extension RawRepresentable {
    init?(optionalValue: RawValue?) {
        guard let value = optionalValue else { return nil }
        self.init(rawValue: value)
    }
}
