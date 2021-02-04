//
//  File.swift
//  
//
//  Created by Joongwon Kim on 2021/02/04.
//

#if !os(watchOS)
import UIKit

public extension UINavigationController {
    func popTo<T>(_ vc: T.Type) {
        let targetVC = viewControllers.first{$0 is T}
        if let targetVC = targetVC {
            popToViewController(targetVC, animated: true)
        }
    }
}
#endif
