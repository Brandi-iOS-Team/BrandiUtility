//
//  Coordinator.swift
//  Brandi
//
//  Created by NohEunTae on 2021/01/11.
//  Copyright © 2020 Brandi. All rights reserved.
//

#if !os(watchOS)
import Foundation
import UIKit

public protocol DestinationRepresentable {
    var destination: UIViewController? { get }
}

public protocol CoordinatorProtocol: AnyObject {
    associatedtype DestinationWrapper: DestinationRepresentable
    
    var source: UIViewController? { get set }
    var destination: UIViewController? { get set }
    
    init(source: UIViewController)
    
    func source(_ viewController: UIViewController?) -> Self
    
    func destination(_ viewController: UIViewController?) -> Self
    func destination(_ destinationWrapper: DestinationWrapper) -> Self
    func destination(options: ModalOption...) -> Self
    
    func present(animated: Bool, completion: (() -> Void)?)
    func push(animated: Bool)
    func pop(to: DestinationWrapper, animated: Bool)
    func pop(to: UIViewController.Type, animated: Bool)
    func popToRoot(animated: Bool)
}

public extension CoordinatorProtocol {
    
    var sourceNavigationController: UINavigationController? {
        (source as? UINavigationController) ?? source?.navigationController
    }
    
    func source(_ viewController: UIViewController?) -> Self {
        source = viewController
        return self
    }
    
}

public extension CoordinatorProtocol {
    
    func destination(_ destinationWrapper: DestinationWrapper) -> Self {
        destination = destinationWrapper.destination
        return self
    }
    
    func destination(_ viewController: UIViewController?) -> Self {
        destination = viewController
        return self
    }
    
    func destination(options: ModalOption...) -> Self {
        options.forEach { $0.apply(in: &destination) }
        return self
    }
    
}

public extension CoordinatorProtocol {
    
    func present(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let destination = destination else { return }
        (sourceNavigationController ?? source)?.present(destination, animated: animated, completion: completion)
    }
    
    func push(animated: Bool = true) {
        guard let destination = destination else { return }
        sourceNavigationController?.pushViewController(destination, animated: animated)
    }
    
    func pop(to: DestinationWrapper, animated: Bool = true) {
        guard let viewControllers = sourceNavigationController?.viewControllers,
              let destination = viewControllers.first(where: { type(of: $0) == type(of: to.destination) }) else { return }
        
        sourceNavigationController?.popToViewController(destination, animated: animated)
    }
    
    func pop(to: UIViewController.Type, animated: Bool = true) {
        guard let viewControllers = sourceNavigationController?.viewControllers,
              let destination = viewControllers.first(where: { type(of: $0) == to }) else { return }
        
        sourceNavigationController?.popToViewController(destination, animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        sourceNavigationController?.popToRootViewController(animated: animated)
    }
    
}

// Use as namespace
public struct Coordinator {}
#endif
