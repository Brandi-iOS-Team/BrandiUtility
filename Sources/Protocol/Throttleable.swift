//
//  Throttleable.swift
//  Hiver
//
//  Created by NohEunTae on 2020/06/01.
//  Copyright © 2020 Brandi. All rights reserved.
//

import Foundation

public protocol Throttleable: AnyObject {
    var timer: Timer? { get set }
}

public extension Throttleable  {
    func throttle(seconds: TimeInterval, function: @escaping () -> Void) {
        guard !(timer?.isValid ?? false) else { return }
        
        if #available(iOS 11.0, watchOS 3.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { [weak self] _ in
                function()
                self?.timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: false) { timer in
                    timer.invalidate()
                }
            })
        } else {
            function()
        }
    }
}
