//
//  UISearchBarExtensions.swift
//  Brandi
//
//  Created by Joo Hee on 20. 09. 07..
//  Copyright © 2020 Brandi. All rights reserved.
//

#if !os(watchOS)
import UIKit

public extension UISearchBar {
    func setAttributedPlaceholder(_ placeholder: NSAttributedString) {
        guard let searchField = self.value(forKey: "searchField") as? UITextField else { return }
        searchField.attributedPlaceholder = placeholder
        searchField.textColor = UIColor.black
    }
    
    func setSearchFieldLeftView(_ view: UIView) {
        guard let searchField = self.value(forKey: "searchField") as? UITextField else { return }
        searchField.leftView = view
        searchField.textColor = UIColor.black
    }
    
    func setSearchFieldTextAttributes(_ attributes: [NSAttributedString.Key: Any]) {
        guard let searchField = self.value(forKey: "searchField") as? UITextField else { return }
        searchField.defaultTextAttributes = attributes
        searchField.textColor = UIColor.black
    }
    
    func setSearchFieldCornerRadius(_ cornerRadius: CGFloat) {
        guard let searchField = self.value(forKey: "searchField") as? UITextField else { return }
        searchField.layer.cornerRadius = cornerRadius
        searchField.layer.masksToBounds = true
        searchField.textColor = UIColor.black
    }
    
    func setAttributesCancelButtonTitle(_ attributes: [NSAttributedString.Key: Any]) {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
    }
}
#endif
