//
//  AnyNameable.swift
//  Brandi
//
//  Created by Joongwon Kim on 2020/06/01.
//  Copyright © 2020 Brandi. All rights reserved.
//

import Foundation

public protocol AnyNameable {
    static func className() -> String
}

public extension AnyNameable {
    static func className() -> String {
        return String(describing: self)
    }
}

extension NSObject: AnyNameable {}
