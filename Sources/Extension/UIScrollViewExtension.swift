//
//  UIScrollView.swift
//  
//
//  Created by NohEunTae on 2021/02/08.
//

#if !os(watchOS)
import UIKit

public extension UIScrollView {
    
    typealias ScrollPosition = UITableView.ScrollPosition
    
    func scrollToView(
        view: UIView,
        position: ScrollPosition = .top,
        animated: Bool) {
                
        guard let scrollPointY = scrollStartPointY(view: view, position: position) else { return }
                
        let targetRect = CGRect(
            origin: .init(x: .zero, y: scrollPointY),
            size: .init(width: .leastNonzeroMagnitude, height: frame.height)
        )
        
        scrollRectToVisible(targetRect, animated: animated)
    }
    
    private func scrollStartPointY(view: UIView, position: ScrollPosition) -> CGFloat? {
        guard let origin = view.superview else { return nil }
        let childStartPoint = origin.convert(view.frame.origin, to: self)
        
        switch position {
        case .bottom:
            return childStartPoint.y + view.frame.height
        case .middle:
            return childStartPoint.y + view.frame.height / 2.0
        case .top:
            return childStartPoint.y
        default:
            return nil
        }
    }
    
}

#endif
