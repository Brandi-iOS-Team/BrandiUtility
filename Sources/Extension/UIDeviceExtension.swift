//
//  UIDeviceExtension.swift
//  Brandi
//
//  Created by Joongwon Kim on 2020/06/15.
//  Copyright © 2020 Brandi. All rights reserved.
//

#if !os(watchOS)
import Foundation
import UIKit

public extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
#endif
