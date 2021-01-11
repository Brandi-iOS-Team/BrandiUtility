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
    func setPlaceHolderText(_ placeholder: String) {
        self.placeholder = placeholder
    }
    
    func setAttributedPlaceholder(_ placeholder: NSAttributedString) {
        guard let searchField = self.value(forKey: "searchField") as? UITextField else { return }
        searchField.attributedPlaceholder = placeholder
        searchField.textColor = .black
    }
    
    func setSearchFieldLeftView(_ view: UIView) {
        guard let searchField = self.value(forKey: "searchField") as? UITextField else { return }
        searchField.leftView = view
        searchField.textColor = .black
    }
    
    func setSearchFieldTextAttributes(_ attributes: [NSAttributedString.Key: Any]) {
        guard let searchField = self.value(forKey: "searchField") as? UITextField else { return }
        searchField.defaultTextAttributes = attributes
        searchField.textColor = .black
    }
    
    func setSearchFieldCornerRadius(_ cornerRadius: CGFloat) {
        guard let searchField = self.value(forKey: "searchField") as? UITextField else { return }
        searchField.layer.cornerRadius = cornerRadius
        searchField.layer.masksToBounds = true
        searchField.textColor = .black
    }
    
    func setSearchFieldCursorClear() {
        guard let searchField = self.value(forKey: "searchField") as? UITextField else { return }
        searchField.tintColor = .clear
        searchField.textColor = .black
    }
    
    func setSearchFieldBackgroundImage(as image: UIImage?) {
        self.setSearchFieldBackgroundImage(image, for: .normal)
    }
    
    func setAttributesCancelButtonTitle(_ attributes: [NSAttributedString.Key: Any]) {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
    }
    
    func setClearButton(image: UIImage, imageEdgeInsets: UIEdgeInsets) {
        guard let textField = value(forKey: "searchField") as? UITextField,
              let button = textField.value(forKey: "clearButton") as? UIButton else { return }
        
        button.imageEdgeInsets = imageEdgeInsets
        setImage(image, for: .clear, state: .normal)
    }
    
    func setCancelButtonTitleEdgeInsets(_ titleEdgeInsets: UIEdgeInsets) {
        guard let button = value(forKey: "cancelButton") as? UIButton else { return }
        button.titleEdgeInsets = titleEdgeInsets
    }
}
#endif
