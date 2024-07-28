//
//  RequestBaseURLProvider.swift
//  
//
//  Created by Fritz Ammon on 1/5/24.
//

import Foundation

public protocol RequestBaseURLProvider {
    var baseURL: URL { get }
}
