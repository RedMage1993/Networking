//
//  Dictionary+Extensions.swift
//
//
//  Created by Fritz Ammon on 2/21/24.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    var asURLQueryItems: [URLQueryItem] {
        flatMap { key, value -> [URLQueryItem] in
            if let array = value as? [Any] {
                return array.map { URLQueryItem(name: "\(key)[]", value: "\($0)") }
            } else if let dictionary = value as? [String: Any] {
                return dictionary.map { nestedKey, nestedValue in
                    URLQueryItem(name: "\(key)[\(nestedKey)]", value: "\(nestedValue)")
                }
            } else if let boolValue = value as? Bool {
                return [URLQueryItem(name: key, value: boolValue ? "true" : "false")]
            } else if value is NSNull {
                return [URLQueryItem(name: key, value: "")]
            } else {
                return [URLQueryItem(name: key, value: "\(value)")]
            }
        }.sorted(using: KeyPathComparator(\.name))
    }
}
