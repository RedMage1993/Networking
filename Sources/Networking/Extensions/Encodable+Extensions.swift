//
//  Encodable+Extensions.swift
//
//
//  Created by Fritz Ammon on 11/7/23.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]

        return dictionary
    }

    func asURLQueryItems() throws -> [URLQueryItem] {
        try asDictionary()?.asURLQueryItems ?? []
    }
}
