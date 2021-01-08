//
//  Debouncer.swift
//  Brandi
//
//  Created by NohEunTae on 2020/08/18.
//  Copyright © 2020 Brandi. All rights reserved.
//

import Foundation

open class Debouncer {
    
    private var currentWorkItem: DispatchWorkItem?
    
    public init() {}
    
    public func debounce(delay: DispatchTimeInterval, queue: DispatchQueue = .main, action: @escaping (() -> Void)) -> () -> Void {
        return {  [weak self] in
            guard let self = self else { return }
            self.currentWorkItem?.cancel()
            self.currentWorkItem = DispatchWorkItem { action() }
            queue.asyncAfter(deadline: .now() + delay, execute: self.currentWorkItem!)
        }
    }
}
