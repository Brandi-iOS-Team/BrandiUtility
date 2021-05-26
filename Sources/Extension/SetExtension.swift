//
//  File.swift
//  
//
//  Created by NohEunTae on 2021/05/25.
//

import Foundation

public extension Set {
    
    @discardableResult mutating func insert(_ newMembers: [Set.Element]) -> [(inserted: Bool, memberAfterInsert: Set.Element)] {
        newMembers.map { insert($0) }
    }
    
}
