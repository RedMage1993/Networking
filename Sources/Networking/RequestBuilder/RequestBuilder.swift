//
//  RequestBuilder.swift
//
//
//  Created by Fritz Ammon on 11/7/23.
//

import Foundation

// swiftlint:disable function_parameter_count
public protocol RequestBuilder {
	var baseURLProvider: RequestBaseURLProvider { get }

	func buildRequest(
		url: URL,
		method: HTTPMethod,
		headers: [String: Any]?,
		parameters: [URLQueryItem]?
	) async throws -> URLRequest
}

public extension RequestBuilder {
    func buildRequest(
        endpoint: String,
        method: HTTPMethod,
        headers: [String: String]?,
        parameters: [URLQueryItem]?
    ) async throws -> URLRequest {
        let url = baseURLProvider.baseURL.appendingPathComponent(endpoint)
        return try await buildRequest(
            url: url,
            method: method,
            headers: headers,
            parameters: parameters
        )
    }

    func buildRequest<T: Encodable>(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]?,
        parameters: [URLQueryItem]?,
        body: T,
        encoder: RequestBodyEncoder
    ) async throws -> URLRequest {
        var request = try await buildRequest(
            url: url,
            method: method,
            headers: headers,
            parameters: parameters
        )

        if let data = try encoder.encodeRequestBody(body) {
            request.httpBody = data
            request.setValue(encoder.contentType, forHTTPHeaderField: "Content-Type")
        }

        return request
    }

    func buildRequest<T: Encodable>(
        endpoint: String,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        parameters: [URLQueryItem]? = nil,
        body: T,
        encoder: RequestBodyEncoder
    ) async throws -> URLRequest {
        let url = baseURLProvider.baseURL.appendingPathComponent(endpoint)
        return try await buildRequest(
            url: url,
            method: method,
            headers: headers,
            parameters: parameters,
            body: body,
            encoder: encoder
        )
    }
}
// swiftlint:enable function_parameter_count
