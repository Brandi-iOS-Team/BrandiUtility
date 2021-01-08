//
//  UIView+Layout.swift
//  Brandi
//
//  Created by Joo Hee on 20. 08. 12..
//  Copyright © 2020 Brandi. All rights reserved.
//

#if !os(watchOS)
import UIKit

public extension UIView {
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    func anchor(size: CGSize) {
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func fillSuperview() {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func anchorFillToSuperViewSafeArea(padding: UIEdgeInsets = .zero) {
        if #available(iOS 11.0, *) {
            anchor(top: superview?.safeAreaLayoutGuide.topAnchor, leading: superview?.safeAreaLayoutGuide.leadingAnchor, bottom: superview?.safeAreaLayoutGuide.bottomAnchor, trailing: superview?.safeAreaLayoutGuide.trailingAnchor, padding: padding)
        } else {
            anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor, padding: padding)
        }
    }
    
    func anchorFillToSuperView(padding: UIEdgeInsets = .zero) {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor, padding: padding)
    }
    
    func hideAndDisable(disable: Bool) {
        self.isHidden = disable
        self.isUserInteractionEnabled = !disable
    }
    
    func disableScrollsToTopPropertyOnAllSubViews() {
        for view in self.subviews {
            if view.isKind(of: UIScrollView.self) {
                if let scroll = view as? UIScrollView {
                    scroll.scrollsToTop = false
                }
            }
        }
    }
    
    func setBorder(_ width: CGFloat, color: UIColor?) {
        self.layer.borderWidth = width
        self.layer.borderColor = color?.cgColor
    }
    
    func removeBorder() {
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    func setCornerRadius(_ radius: CGFloat) {
        self.setCornerRadius(radius, borderWidth: 0.0, borderColor: nil)
    }
    
    func setCornerRadius(_ radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor?) {
        if let _ = borderColor {
            self.layer.borderColor = borderColor?.cgColor
            self.layer.borderWidth = borderWidth
        }
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
    func setBorderStyle(width: CGFloat?, color: UIColor?, radius: CGFloat?) {
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
    
    func addShadowIntoView(_ color: UIColor, offset: CGSize, opacity: CGFloat, radius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = Float(opacity)
        self.layer.shadowRadius = radius
    }
    
    func addBlurEffect() {
        GUIUtility.addBlurEffectInto(self)
    }
    
    func addBlurEffect(style: UIBlurEffect.Style) {
        GUIUtility.addBlurEffectInto(self, style: style)
    }
    
    func addNotiDotIntoView(_ notiDotColor: UIColor, offset: CGPoint?) {
        let STRING_ID_BADGE: Int = 12067841
        for view in self.subviews {
            if view.tag == STRING_ID_BADGE {
                view.removeFromSuperview()
            }
        }
        let size = CGSize(width: 4, height: 4)
        var offsetX: CGFloat = 0.0
        var offsetY: CGFloat = 0.0
        if let coordinate = offset {
            offsetX = coordinate.x
            offsetY = coordinate.y
        }
        let frame = CGRect(x: self.frame.size.width - size.width + offsetX, y: size.width + offsetY, width: size.width, height: size.height)
        let dot = UIView(frame: frame)
        dot.backgroundColor = notiDotColor
        dot.setCornerRadius(dot.frame.size.width/2)
        self.addSubview(dot)
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func removeAllConstraints() {
        var _superview = self.superview
        while let superview = _superview {
            for constraint in superview.constraints {
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            _superview = superview.superview
        }
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func findConstraint(layoutAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        if let constraints = superview?.constraints {
            for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
                return constraint
            }
        }
        return nil
    }
    
    func itemMatch(constraint: NSLayoutConstraint, layoutAttribute: NSLayoutConstraint.Attribute) -> Bool {
        if let firstItem = constraint.firstItem as? UIView, let secondItem = constraint.secondItem as? UIView {
            let firstItemMatch = firstItem == self && constraint.firstAttribute == layoutAttribute
            let secondItemMatch = secondItem == self && constraint.secondAttribute == layoutAttribute
            return firstItemMatch || secondItemMatch
        }
        return false
    }
}

public struct AnchoredConstraints {
    public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}
#endif
