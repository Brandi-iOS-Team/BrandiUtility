//
//  UIViewControllerExtension.swift
//  Brandi
//
//  Created by Joo Hee on 20. 06. 12..
//  Copyright © 2020 Brandi. All rights reserved.
//

#if !os(watchOS)
import UIKit

public extension UIViewController {
    func setNavigationBarBorderColor(_ color: UIColor = UIColor(hex: "#f2f4f7") ?? .clear) {
        navigationController?.navigationBar.shadowImage = color.asImage(height: 1)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}
#endif
