//
//  DictionaryExtension.swift
//  Brandi
//
//  Created by Joo Hee on 20. 11. 16..
//  Copyright © 2020 Brandi. All rights reserved.
//

import Foundation

public extension Dictionary where Value: Equatable {
    func getKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
    
    func allKeys(forValue val: Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}
