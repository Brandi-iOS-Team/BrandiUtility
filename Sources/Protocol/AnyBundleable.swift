//
//  AnyBundleable.swift
//  Brandi
//
//  Created by NohEunTae on 2020/08/19.
//  Copyright © 2020 Brandi. All rights reserved.
//

import Foundation

public protocol AnyBundleable {
    
    static var bundle: Bundle { get }
    
    var bundle: Bundle { get }
    
}

public extension AnyBundleable where Self: NSObject {
    
    static var bundle: Bundle {
        return Bundle(for: self)
    }
    
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
}

extension NSObject: AnyBundleable {}
