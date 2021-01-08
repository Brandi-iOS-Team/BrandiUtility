//
//  NSLayoutConstraintsExtend.swift
//  Brandi
//
//  Created by brandi on 2016. 6. 21..
//  Copyright © 2016년 Brandi. All rights reserved.
//

#if !os(watchOS)
import Foundation
import UIKit

public extension NSLayoutConstraint {
    @IBInspectable private var preciseConstant: Int {
        get {
            return Int(self.constant * UIScreen.main.scale)
        }
        set {
            self.constant = CGFloat(newValue) / UIScreen.main.scale
        }
    }
}
#endif
