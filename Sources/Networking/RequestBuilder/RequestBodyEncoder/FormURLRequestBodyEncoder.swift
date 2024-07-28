//
//  FormURLRequestBodyEncoder.swift
//  
//
//  Created by Fritz Ammon on 11/12/23.
//

import Foundation

public struct FormURLRequestBodyEncoder: RequestBodyEncoder {
    public let contentType = "application/x-www-form-urlencoded; charset=utf-8"

    public init() {}

    public func encodeRequestBody<T: Encodable>(_ body: T) throws -> Data? {
        var urlComponents = URLComponents()
        urlComponents.queryItems = try body.asURLQueryItems()

        return urlComponents.percentEncodedQuery?.data(using: .utf8)
    }
}
