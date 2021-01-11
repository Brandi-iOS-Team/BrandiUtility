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
        navigationController?.navigationBar.shadowImage = color.toImage(height: 1)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
#endif
