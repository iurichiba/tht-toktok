//
//  HTTPClient.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 04/12/22.
//

import Foundation

final class HTTPClient: HTTPClientProtocol {
    private let baseURL: URL
    private let urlSession: URLSession
    
    init(baseURL: URL, urlSession: URLSession) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    private func makeUrl(base: URL, path: String, query: [URLQueryItem]?) -> URL {
        let url = base.appendingPathComponent(path)
        if let query = query, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            components.queryItems = query
            return components.url!
            // force-unwrapped because shouldn't fail.
            // if it ever fails, this should be investigated, not hidden
        }
        return url
    }
    
    func perform<T>(_ request: HTTPRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        var urlRequest = URLRequest(url: makeUrl(base: baseURL, path: request.endpoint.path, query: request.endpoint.query))
        urlRequest.httpBody = request.endpoint.body
        urlRequest.httpMethod = request.type.rawValue
        
        urlSession.dataTask(with: urlRequest) { data, response, error in
            // validation for request error
            guard error == nil else {
                return completion(.failure(error!))
            }
            
            // validation for valid status and data
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode),
                  let data = data,
                  let decoded = try? JSONHelper.sharedDecoder.decode(T.self, from: data) else {
                return completion(.failure(HTTPClientError.badRequest))
            }
            
            // if everything goes alright, return as success
            return completion(.success(decoded))
        }.resume()
    }
}

// MARK: - Generic & Expected Errors
enum HTTPClientError: Error {
    case badRequest
    // add more as needed
}
