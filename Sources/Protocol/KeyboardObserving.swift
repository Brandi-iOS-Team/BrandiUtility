//
//  KeyboardObserving.swift
//  Hiver
//
//  Created by Joo Hee on 20. 11. 24..
//  Copyright © 2020 Brandi. All rights reserved.
//

#if !os(watchOS)
import UIKit

/*
 * 현재는 keyboardWillShow 와 keyboardWillHide 만 필요하여 두 개만 있습니다.
 * 다른 Notification에 대하여 작업할 필요가 있을 경우, 추가해주세요.
 */

@objc public protocol KeyboardObserving: AnyObject {
    @objc func keyboardWillShow(_ notification: Notification)
    @objc func keyboardWillHide(_ notification: Notification)
}

public extension KeyboardObserving {
    
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}
#endif
