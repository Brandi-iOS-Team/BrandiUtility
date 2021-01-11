//
//  NibInitable.swift
//  Brandi
//
//  Created by Joongwon Kim on 2020/06/01.
//  Copyright © 2020 Brandi. All rights reserved.
//

#if !os(watchOS)
import UIKit

public protocol NibInitable {
    static func initFromNib() -> Self?
}

public extension NibInitable where Self: UIView {
    static func initFromNib() -> Self? {
        let xibName = String(describing: self)
        guard let _ = bundle.path(forResource: xibName, ofType: "nib") else { return nil }
        return bundle.loadNibNamed(xibName, owner: nil, options: nil)?.first as? Self
    }
}

public extension NibInitable where Self: UIViewController {
    static func initFromNib() -> Self? {
        let xibName = String(describing: self)
        return ((Self)(nibName: xibName, bundle: bundle))
    }
}

extension UIView: NibInitable {}
extension UIViewController: NibInitable {}
#endif
