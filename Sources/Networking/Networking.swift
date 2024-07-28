//
//  Networking.swift
//
//
//  Created by Fritz Ammon on 11/13/23.
//

public protocol Networking {
    var networkTransport: NetworkTransport { get }
    var requestBuilder: RequestBuilder { get }
}
