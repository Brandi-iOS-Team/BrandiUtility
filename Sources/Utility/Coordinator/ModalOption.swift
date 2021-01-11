//
//  ModalOption.swift
//  Brandi
//
//  Created by NohEunTae on 2021/01/11.
//  Copyright © 2020 Brandi. All rights reserved.
//

#if !os(watchOS)
import Foundation
import UIKit

public enum ModalOption {
    
    case modalPresentationStyle(_ style: UIModalPresentationStyle)
    case modalTransitionStyle(_ style: UIModalTransitionStyle)
    case wrapping(_ navigationController: UINavigationController = .init())
    
    func apply(in viewController: inout UIViewController?) {
        switch self {
        case .modalPresentationStyle(let style):
            viewController?.modalPresentationStyle = style
        case .modalTransitionStyle(let style):
            viewController?.modalTransitionStyle = style
        case .wrapping(let navi):
            guard let viewControllerWrapped = viewController else { return }
            
            navi.viewControllers = [viewControllerWrapped]
            viewController = navi
        }
    }
    
}
#endif
