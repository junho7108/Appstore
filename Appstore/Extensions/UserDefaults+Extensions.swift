//
//  UserDefaults+Extensions.swift
//  Appstore
//
//  Created by Junho Yoon on 9/21/24.
//

import Foundation

extension UserDefaults {
    public subscript(key: String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    public func object<T: Codable>(_ type: T.Type, forKey key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        
        guard let data = value(forKey: key) as? Data else { return nil }
        
        return try? decoder.decode(type.self, from: data)
    }
    
    public func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        
        let data = try? encoder.encode(object)
        
        set(data, forKey: key)
    }
}
