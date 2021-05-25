//
//  File.swift
//  
//
//  Created by NohEunTae on 2021/05/25.
//

import Foundation

public extension Set {
    
    @discardableResult mutating func insert(_ newMembers: [Set.Element]) -> [(inserted: Bool, memberAfterInsert: Set.Element)] {
        var returnArray: [(inserted: Bool, memberAfterInsert: Set.Element)] = []
        newMembers.forEach { (member) in
            returnArray.append(self.insert(member))
        }
        return returnArray
    }
    
}
