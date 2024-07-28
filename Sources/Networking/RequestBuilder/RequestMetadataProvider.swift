//
//  RequestMetadataProvider.swift
//
//
//  Created by Fritz Ammon on 11/16/23.
//

import Foundation

public protocol RequestMetadataProvider {
    func globalHeaders() async throws -> [String: Any]?
    func globalParameters() async throws -> [URLQueryItem]?
}
