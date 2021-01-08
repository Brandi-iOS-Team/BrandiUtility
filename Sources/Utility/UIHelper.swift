//
//  UIHelper.swift
//  
//
//  Created by Joo Hee Kim on 21. 01. 08..
//

import UIKit

enum UIHelper {
    
    /// Zeplin Line Height 값을 Line Spacing으로 변환합니다.
    static func lineSpacing(from lineHeight: CGFloat, font: UIFont) -> CGFloat {
        let value = lineHeight - font.lineHeight
        return value
    }
    
}
