//
//  UITableViewExtend.swift
//  Brandi
//
//  Created by brandi on 2016. 5. 23..
//  Copyright © 2016년 Brandi. All rights reserved.
//

#if !os(watchOS)
import Foundation
import UIKit

public extension UITableView {
    func refreshData() {
        self.reloadData()
        var hasData = false
        for section in 0 ..< self.numberOfSections {
            if self.numberOfRows(inSection: section) > 0 {
                hasData = true
            }
        }
        self.backgroundView?.isHidden = hasData
    }
    
    func setBottomIndicator(hide: Bool) {
        let height: CGFloat = 30
        let indicator = UIActivityIndicatorView(style: .gray)

        indicator.frame = CGRect(x: .zero, y: .zero, width: contentSize.width, height: height)
        indicator.center.x = center.x
        indicator.isHidden = hide
        
        if !hide { indicator.startAnimating() }

        tableFooterView = hide
            ? nil
            : indicator
    }
}
#endif
