//
//  URL+Extensions.swift
//  Common
//
//  Created by Fritz Ammon on 2/5/24.
//

import Foundation

extension URL {
    mutating func merge(queryItems: [URLQueryItem], uniquingKeysWith combine: (String, String) -> String) {
        self = merging(queryItems: queryItems, uniquingKeysWith: combine)
    }

    @discardableResult
    func merging(queryItems: [URLQueryItem], uniquingKeysWith combine: (String, String) -> String) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)

        let newQueryItems = (components?.percentEncodedQueryItems ?? [])
            .asDictionary
            .merging(queryItems.asDictionary) { $1 }
            .map { URLQueryItem(name: $0.key, value: $0.value) }

        if !newQueryItems.isEmpty {
            components?.percentEncodedQueryItems = newQueryItems
        }

        return components?.url ?? self
    }
}
