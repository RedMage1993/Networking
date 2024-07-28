//
//  RequestBodyEncoder.swift
//
//
//  Created by Fritz Ammon on 11/12/23.
//

import Foundation

public protocol RequestBodyEncoder {
    var contentType: String { get }

    func encodeRequestBody<T: Encodable>(_ body: T) throws -> Data?
}
