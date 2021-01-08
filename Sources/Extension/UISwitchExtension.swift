//
//  UISwitch+Extension.swift
//  Brandi
//
//  Created by Joo Hee Kim on 21. 01. 04..
//  Copyright © 2021 Brandi. All rights reserved.
//

#if !os(watchOS)
import UIKit

public extension UISwitch {
    func set(width: CGFloat, height: CGFloat) {
        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51
        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth
        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}
#endif
