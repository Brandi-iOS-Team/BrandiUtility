//
//  ObjectMapperTransformUtility.swift
//  Hiver
//
//  Created by Joongwon Kim on 2020/04/29.
//  Copyright © 2020 Brandi. All rights reserved.
//

import Foundation
import ObjectMapper

open class BrandiIntTransform: TransformType {
    public typealias Object = Int
    public typealias JSON = Int
    
    public init() {}
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            return value
        }
        return nil
    }
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value =  value as? String {
            return Int(value)
        } else if let value = value as? Int {
            return value
        }
        return nil
    }
}

open class BrandiStringTransform: TransformType {
    public typealias Object = String
    public typealias JSON = String
    
    public init() {}
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            return value
        }
        return nil
    }
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value =  value as? Int {
            return String(value)
        } else if let value = value as? String {
            return value
        }
        
        return nil
    }
}

open class BrandiStringArrayTransform: TransformType {
    public typealias Object = [String]
    public typealias JSON = [String]
    
    public init() {}
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            return value
        }
        return nil
    }
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value =  value as? [Int] {
            return value.map({String($0)})
        } else if let value = value as? [String] {
            return value
        }
        
        return nil
    }
}

open class BrandiStringEnumTransform<T: RawRepresentable>: TransformType {
    public typealias Object = T
    public typealias JSON = T.RawValue
    
    public init() {}
    
    public func transformToJSON(_ value: Object?) -> T.RawValue? {
        if let value = value {
            return value.rawValue
        }
        return nil
    }
    
    public func transformFromJSON(_ value: Any?) -> T? {
        if let value =  value as? Int, let raw = String(value) as? T.RawValue {
            return T(rawValue: raw)
        } else if let value = value as? String, let raw = value as? T.RawValue {
            return T(rawValue: raw)
        }
        return nil
    }
}

open class BrandiIntEnumTransform<T: RawRepresentable>: TransformType {
    public typealias Object = T
    public typealias JSON = T.RawValue
    
    public init() {}
    
    public func transformToJSON(_ value: Object?) -> T.RawValue? {
        if let value = value {
            return value.rawValue
        }
        return nil
    }
    
    public func transformFromJSON(_ value: Any?) -> T? {
        if let value =  value as? String, let raw = Int(value) as? T.RawValue {
            return T(rawValue: raw)
        } else if let value = value as? Int, let raw = value as? T.RawValue {
            return T(rawValue: raw)
        }
        return nil
    }
}

open class BrandiDateTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    static let reusableDateFormatter = DateFormatter(withFormat: "yyyy-MM-dd", locale: "en_US_POSIX")
    
    public init() {}
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            return type(of: self).reusableDateFormatter.string(from: value)
        }
        return nil
    }
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value =  value as? String {
            if let doubleValue = Double(value) {
                return Date(timeIntervalSince1970: TimeInterval(doubleValue))
            } else if let timezoneFormat = type(of: self).reusableDateFormatter.date(from: value) {
                return timezoneFormat
            } else {
                return nil
            }
        } else if let value = value as? Double, value > 0 {
            return Date(timeIntervalSince1970: TimeInterval(value))
        }
        return nil
    }
}
