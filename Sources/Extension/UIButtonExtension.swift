//
//  UIButtonExtensions.swift
//  Brandi
//
//  Created by Joo Hee on 20. 08. 20..
//  Copyright © 2020 Brandi. All rights reserved.
//

#if !os(watchOS)
import UIKit

public extension UIButton {
    convenience init(text: String, textColor: UIColor, bgColor: UIColor) {
        self.init(frame: .zero)
        
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.setBackgroundColor(color: bgColor, forState: .normal)
    }
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
    
    func fittingSize(title: String, font: UIFont, horizontalPadding: CGFloat, maxHeight: CGFloat) -> CGSize {
        let label = UILabel(frame: .init(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: maxHeight))
        label.font = font
        label.text = title
        label.sizeToFit()
        return .init(width: label.intrinsicContentSize.width + (horizontalPadding * 2), height: label.intrinsicContentSize.height)
    }
    
}
#endif
