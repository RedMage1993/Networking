//
//  JSONRequestBodyEncoder.swift
//  
//
//  Created by Fritz Ammon on 11/12/23.
//

import Foundation

public struct JSONRequestBodyEncoder: RequestBodyEncoder {
    public let contentType = "application/json"

    public init() {}

    public func encodeRequestBody<T: Encodable>(_ body: T) throws -> Data? {
        try JSONEncoder().encode(body)
    }
}
