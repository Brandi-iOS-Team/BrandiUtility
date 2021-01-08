//
//  UIStackViewExtensions.swift
//  Brandi
//
//  Created by Joo Hee on 20. 06. 10..
//  Copyright © 2020 Brandi. All rights reserved.
//

#if !os(watchOS)
import UIKit

public extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
    
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach{$0.removeFromSuperview()}
    }
}
#endif
