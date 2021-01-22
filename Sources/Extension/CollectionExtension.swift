//
//  CollectionExtension.swift
//  Brandi
//
//  Created by Joongwon Kim on 2020/05/15.
//  Copyright © 2020 Brandi. All rights reserved.
//

public extension Collection {
    // Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    var isNotEmpty: Bool {
        !isEmpty
    }
}

public extension MutableCollection {
    // Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        set {
            if let newValue = newValue, indices.contains(index) {
                self[index] = newValue
            }
        }

        get {
            return indices.contains(index) ? self[index] : nil
        }

    }
}
