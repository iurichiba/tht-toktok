//
//  HTTPClientProtocol.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 04/12/22.
//

import Foundation

// MARK: - Base Definitions
struct HTTPRequest {
    let endpoint: Endpoint
    let type: HTTPRequestMethod
}

protocol Endpoint {
    var path: String { get }
    var query: [URLQueryItem]? { get }
    var body: Data? { get }
}

enum HTTPRequestMethod: String {
    case get = "GET"
    // add other methods (like PUT, POST, DELETE, etc) as needed
}

// MARK: - Main Protocol
protocol HTTPClientProtocol {
    func perform<T: Decodable>(_ request: HTTPRequest, completion: @escaping (Result<T, Error>) -> Void)
}
