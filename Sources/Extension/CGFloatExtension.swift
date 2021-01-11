//
//  CGFloatExtension.swift
//  Hiver
//
//  Created by 이정환 on 2020/10/19.
//  Copyright © 2020 Brandi. All rights reserved.
//

import UIKit

public extension CGFloat {
    func int() -> Int {
        return Int(self)
    }
    
    func ceiled() -> CGFloat {
        let float = ceil(Float(self))
        return CGFloat(float)
    }
    
    func floored() -> CGFloat {
        let float = floorf(Float(self))
        return CGFloat(float)
    }
    
    func rounded() -> CGFloat {
        let float = roundf(Float(self))
        return CGFloat(float)
    }

    func multiplied(by: CGFloat) -> CGFloat {
        return self * by
    }

    func multiplied(by: Int) -> CGFloat {
        return self * by.cgfloat()
    }

    func absolute() -> CGFloat {
        return abs(self)
    }
}
