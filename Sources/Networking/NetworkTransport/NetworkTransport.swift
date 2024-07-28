//
//  NetworkTransport.swift
//
//
//  Created by Fritz Ammon on 11/7/23.
//

import Foundation

public protocol NetworkTransport {
    func fetchData(_ request: URLRequest) async throws -> Data
}

public enum NetworkTransportError: Error {
    case noResponse
    case badResponse(Data, HTTPURLResponse)
    case decodingError(Data, String)
}

extension NetworkTransport {
    public func executeRequest(_ request: URLRequest) async throws {
        _ = try await fetchData(request)
    }

    public func decodeObject<T: Decodable>(_ data: Data, jsonDecoder: JSONDecoder = JSONDecoder()) throws -> T {

        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch DecodingError.dataCorrupted(let context) {
            let detail = "\(context.debugDescription)"
            throw NetworkTransportError.decodingError(data, detail)
        } catch DecodingError.keyNotFound(let key, let context) {
            let detail = "Keys \(context.codingPath.map { key in key.stringValue }.joined(separator: "->"))\n" + "API Parsing Error: (keyNotFound) \(key.stringValue) was not found, \(context.debugDescription)"
            throw NetworkTransportError.decodingError(data, detail)
        } catch DecodingError.typeMismatch(let type, let context) {
            let detail = "Keys \(context.codingPath.map { key in key.stringValue }.joined(separator: "->"))\n" + "API Parsing Error: (typeMismatch) \(type) was expected, \(context.debugDescription)"
            throw NetworkTransportError.decodingError(data, detail)
        } catch DecodingError.valueNotFound(let type, let context) {
            let detail = "API Parsing Error: (typeMismatch) \(type) was expected, \(context.debugDescription)\n" + "Keys \(context.codingPath.map { key in key.stringValue }.joined(separator: "->"))\n" + "API Parsing Error: (valueNotFound) no value was found for \(type), \(context.debugDescription)"
            throw NetworkTransportError.decodingError(data, detail)
        } catch {
            let detail = "API Parsing Error: I know not this error"
            throw NetworkTransportError.decodingError(data, detail)
        }
    }

    public func executeRequest<T: Decodable>(_ request: URLRequest, jsonDecoder: JSONDecoder = JSONDecoder()) async throws -> T {
        let data = try await fetchData(request)
        return try decodeObject(data, jsonDecoder: jsonDecoder)
    }
}
