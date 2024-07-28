//
//  Array+Extensions.swift
//
//
//  Created by Fritz Ammon on 11/13/23.
//

import Foundation

extension Array where Element == URLQueryItem {
    var asDictionary: [String: String] {
        reduce(into: [:]) { $0[$1.name] = $1.value }
    }
}
