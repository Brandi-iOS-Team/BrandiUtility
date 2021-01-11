//
//  StoryboardInitable.swift
//  Brandi
//
//  Created by NohEunTae on 2020/08/18.
//  Copyright © 2020 Brandi. All rights reserved.
//

#if !os(watchOS)
import UIKit

public protocol StoryboardInitable {
    static func initFromStoryboard(_ name: String) -> Self?
}

public extension StoryboardInitable where Self: UIViewController {
    static func initFromStoryboard(_ name: String = Self.className()) -> Self? {
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        let identifier: String = Self.className()
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        return viewController as? Self
    }
}

extension UIViewController: StoryboardInitable {}
#endif
