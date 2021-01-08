//
//  CollectionExtension.swift
//  Brandi
//
//  Created by Joongwon Kim on 2020/05/15.
//  Copyright © 2020 Brandi. All rights reserved.
//

public extension Array {
    subscript(safe range: Range<Index>) -> ArraySlice<Element> {
        return self[Swift.min(range.lowerBound, endIndex)..<Swift.min(range.upperBound, endIndex)]
    }
}

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
