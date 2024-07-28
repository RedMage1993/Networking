//
//  DefaultNetworking.swift
//
//
//  Created by Fritz Ammon on 11/13/23.
//

import Foundation

public class DefaultNetworking: Networking {
    public let networkTransport: NetworkTransport
    public let requestBuilder: RequestBuilder

    public init(networkTransport: NetworkTransport = DefaultNetworkTransport(), requestBuilder: RequestBuilder) {
        self.networkTransport = networkTransport
        self.requestBuilder = requestBuilder
    }
}
