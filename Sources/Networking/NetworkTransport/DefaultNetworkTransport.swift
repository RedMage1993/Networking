//
//  DefaultNetworkTransport.swift
//
//
//  Created by Fritz Ammon on 11/9/23.
//

import Foundation

public struct DefaultNetworkTransport: NetworkTransport {
    let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func fetchData(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await session.data(for: request)

        guard let response = response as? HTTPURLResponse else {
            throw NetworkTransportError.noResponse
        }

        guard (200...299).contains(response.statusCode) else {
            throw NetworkTransportError.badResponse(data, response)
        }

        return data
    }
}
