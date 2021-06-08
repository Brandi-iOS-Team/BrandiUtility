//
//  UICollcectionViewExtend.swift
//  Brandi
//
//  Created by Ryan on 2016. 4. 8..
//  Copyright © 2016년 Brandi. All rights reserved.
//

#if !os(watchOS)
import Foundation
import UIKit

public extension UICollectionView {
    
    private func findSuperVC(_ responder: UIResponder) -> UIViewController? {
        guard let next = responder.next else { return nil }
        
        guard let vc = next as? UIViewController else {
            return findSuperVC(next)
        }
        
        return vc
    }

    var fullyVisibleCells: [UICollectionViewCell] {
        let superVC = findSuperVC(self)
        return visibleCells.filter {
            guard let superview = superVC?.view else {
                return bounds.contains($0.frame)
            }
            
            let cellRect = convert($0.frame, to: superview)
            return superview.bounds.contains(cellRect)
        }
    }
    
    var fullyVisibleCellIndexPaths: [IndexPath] {
        fullyVisibleCells
            .compactMap { indexPath(for: $0) }
    }

    func fullyVisibleReusableViews(ofKind elementKind: String) -> [UICollectionReusableView] {
        let superVC = findSuperVC(self)
        return visibleSupplementaryViews(ofKind: elementKind)
            .filter {
                guard let superview = superVC?.view else {
                    return bounds.contains($0.frame)
                }
                
                let viewRect = convert($0.frame, to: superview)
                return superview.bounds.contains(viewRect)
            }
    }
    
    func fullyVisibleReusableIndexPaths(ofKind elementKind: String) -> [IndexPath] {
        fullyVisibleReusableViews(ofKind: elementKind)
            .compactMap { indexPathForVisibleSupplementaryView(for:$0, ofKind: elementKind) }
    }
    
    func indexPathForVisibleSupplementaryView(for view: UICollectionReusableView, ofKind elementKind: String) -> IndexPath? {
        let indexPaths = indexPathsForVisibleSupplementaryElements(ofKind: elementKind)
        let views = visibleSupplementaryViews(ofKind: elementKind)
        let items: [(indexPath: IndexPath, reusableView: UICollectionReusableView)] = Array(zip(indexPaths, views))
        
        return items.first { $0.reusableView == view }?.indexPath
    }

}

public extension UICollectionView {
    
    func refreshData() {
        self.reloadData()
        var hasData = false
        for section in 0 ..< numberOfSections {
            if numberOfItems(inSection: section) > 0 {
                hasData = true
                break
            }
        }
        backgroundView?.isHidden = hasData
        setBottomIndicator(hide: true, isFinishedPaging: false)
    }
    
    func refreshDataInDefaultSettings() {
        reloadData()
        setBottomIndicator(hide: true, isFinishedPaging: false)
    }
    
    func setBottomIndicator(hide: Bool, isFinishedPaging: Bool) {
        let tag = hashValue
        var indicator: UIActivityIndicatorView?
        for view in subviews {
            if view.tag == tag {
                indicator = view as? UIActivityIndicatorView
                break
            }
        }
        let height: CGFloat = 30
        let bottomOffset: CGFloat = height * 3
        if indicator == nil, !hide {
            indicator = UIActivityIndicatorView(style: .gray)
            indicator?.tag = tag
            contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: bottomOffset, right: contentInset.right)
            addSubview(indicator!)
        }
        if hide, isFinishedPaging {
            contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: 0, right: contentInset.right)
        } else if !hide {
            contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: bottomOffset, right: contentInset.right)
        }
        if indicator != nil {
            indicator?.frame = CGRect(x: 0, y: contentSize.height, width: contentSize.width, height: height)
            indicator?.center.x = center.x
            bringSubviewToFront(indicator!)
        }
        if !hide {
            indicator?.startAnimating()
        } else {
            indicator?.stopAnimating()
        }
        indicator?.isHidden = hide
    }
    
    func isLastRow(for indexPath: IndexPath) -> Bool {
        let lastRow = (numberOfItems(inSection: indexPath.section) - 1)
        return lastRow == indexPath.row
    }
    
    func scrollToItemIfEnabled(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        guard numberOfSections > indexPath.section else { return }
        let itemCount = numberOfItems(inSection: indexPath.section)
        guard itemCount > indexPath.item else { return }
        scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    func reloadItemsIfEnabled(at indexPaths: [IndexPath], animated: Bool = false) {
        let visibleIndexPaths = indexPathsForVisibleItems.compactMap { indexPaths.contains($0) ? $0 : nil }
        guard visibleIndexPaths.isNotEmpty else { return }
        if animated {
            reloadItems(at: indexPaths)
        } else {
            UIView.performWithoutAnimation {
                reloadItems(at: indexPaths)
            }
        }
    }
    
    func reloadSectionsIfEnabled(at indexSet: IndexSet) {
        if numberOfSections > indexSet.rangeView.endIndex {
            reloadSections(indexSet)
        }
    }
    
    func configure<T: UICollectionViewDataSource & UICollectionViewDelegate>(adapter: T) {
        dataSource = adapter
        delegate = adapter
    }
}
#endif
