//
//  UITabBarItemExtend.swift
//  Hiver
//
//  Created by NohEunTae on 2020/09/17.
//  Copyright © 2020 Brandi. All rights reserved.
//

#if !os(watchOS)
import UIKit

public extension UITabBarItem {
    
    private var dotBadgeIdentifier: String { "DotBadgeIdentifier" }
    
    private var contentView: UIView? {
        guard let view = self.value(forKey: "view") as? UIView,
            let kind = NSClassFromString("UITabBarButton"),
            view.isKind(of: kind) else {
            return nil
        }
        return view
    }
    
    private var imageView: UIImageView? {
        contentView?.subviews.compactMap {
            guard let kind = NSClassFromString("UITabBarSwappableImageView"),
                $0.isKind(of: kind) else { return nil }
            return $0 as? UIImageView
        }.first
    }
    
    var dotBadge: UIView? {
        guard let view = imageView else { return nil }
        let badge = view.subviews.first { $0.accessibilityIdentifier == dotBadgeIdentifier }
        return badge
    }
    
    func addDotBadge() {
        guard let view = imageView else { return }
        if let dotBadge = dotBadge {
            dotBadge.removeFromSuperview()
        }
        
        let badge = UIView()
        badge.accessibilityIdentifier = dotBadgeIdentifier
        badge.layer.cornerRadius = 2
        badge.clipsToBounds = true
        badge.backgroundColor = .clear
        
        view.addSubview(badge)
        badge.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 2, left: 0, bottom: 0, right: 2), size: .init(width: 4, height: 4))
    }
    
}
#endif
