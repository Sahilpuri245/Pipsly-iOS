//
//  Serialization.swift
//  ServiceProject
//
//  Created by Sumit Tripathi on 05/12/17.
//  Copyright © 2018 Route. All rights reserved.
//

import Foundation

public typealias Serialization = [String: Any]

public protocol SerializationKey {
    var strValue: String { get }
}

extension RawRepresentable where RawValue == String {
    public var strValue: String {
		return rawValue
	}
}

public protocol SerializationValue {}

extension Bool: SerializationValue {}
extension String: SerializationValue {}
extension Int: SerializationValue {}
extension Int32: SerializationValue {}
extension Int64: SerializationValue {}
extension Double: SerializationValue {}
extension Float: SerializationValue {}
extension Dictionary: SerializationValue {}
extension Array: SerializationValue {}

extension Dictionary where Key == String, Value: Any {
    public func value<V: SerializationValue>(forKey key: SerializationKey) -> V? {
		return self[key.strValue] as? V
	}
}

extension Sequence where Iterator.Element == Serialization {
    public func getList<T: BaseModel>() -> [T] {
        return map { user in
            return T(serialization: user)
        }
    }

    public func getObject<T: BaseModel>() -> [T] {
        return map { user in
            return T(serialization: user)
        }
    }
    
}
