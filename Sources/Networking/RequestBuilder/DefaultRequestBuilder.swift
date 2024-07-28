//
//  DefaultRequestBuilder.swift
//
//
//  Created by Fritz Ammon on 11/9/23.
//

import Foundation

public class DefaultRequestBuilder: RequestBuilder {
	public let baseURLProvider: RequestBaseURLProvider
	public let metadataProvider: RequestMetadataProvider

	public init(baseURLProvider: RequestBaseURLProvider, metadataProvider: RequestMetadataProvider) {
		self.baseURLProvider = baseURLProvider
		self.metadataProvider = metadataProvider
	}

	public func buildRequest(
		url: URL,
		method: HTTPMethod,
		headers: [String: Any]? = nil,
		parameters: [URLQueryItem]? = nil
	) async throws -> URLRequest {
		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue

		let globalParameters = try await metadataProvider.globalParameters() ?? []
		let mergedParameters = globalParameters
			.asDictionary
			.merging((parameters ?? []).asDictionary) { $1 }
			.map { URLQueryItem(name: $0.key, value: $0.value) }

		request.url?.merge(queryItems: mergedParameters) { $1 }

		let globalHeaders = try await metadataProvider.globalHeaders() ?? [:]
		let mergedHeaders = globalHeaders.merging(headers ?? [:]) { $1 }
		mergedHeaders.forEach { key, value in
			request.setValue("\(value)", forHTTPHeaderField: key)
		}

		return request
	}
}
