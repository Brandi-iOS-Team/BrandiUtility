//
//  UITextFieldExtension.swift
//  Brandi
//
//  Created by Ryan Lee on 2017. 9. 17..
//  Copyright © 2017년 Brandi. All rights reserved.
//

#if !os(watchOS)
import UIKit

public extension UITextField {
    func addIndentIntoLeft(_ indentWidth: CGFloat) {
        let paddingFrame = CGRect(x: 0, y: 0, width: indentWidth, height: self.frame.size.height)
        let paddingView = UIView(frame: paddingFrame)
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    func addIndentIntoRight(_ indentWidth: CGFloat) {
        let paddingFrame = CGRect(x: 0, y: 0, width: indentWidth, height: self.frame.size.height)
        let paddingView = UIView(frame: paddingFrame)
        self.rightView = paddingView
        self.rightViewMode = UITextField.ViewMode.always
    }
    
    func setToDefaultView(color: CGColor) {
        self.borderStyle = .none
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 8
        self.layer.borderColor = color
    }
    
    func setTextFieldBorderStyle(style: UITextField.BorderStyle = .none, width: CGFloat?, color: UIColor?, radius: CGFloat?) {
        self.borderStyle = style
        if let width = width {
            self.layer.borderWidth = width
        }
        if let color = color {
            self.layer.borderColor = color.cgColor
        }
        if let radius = radius {
            self.layer.cornerRadius = radius
        }
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}
#endif
