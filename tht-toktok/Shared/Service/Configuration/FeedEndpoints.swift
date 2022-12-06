//
//  FeedEndpoints.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 04/12/22.
//

import Foundation

// MARK: - Base Configurations
struct FeedEndpointConfig {
    static let pageSize = 100 // pagination isn't implemented yet
}

enum FeedEndpoint: Endpoint {
    case feed
    // add other endpoints, as needed
    
    var path: String {
        switch self {
        case .feed: return "/videos"
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
        case .feed: return [URLQueryItem(name: "page_number", value: String(0)),
                            URLQueryItem(name: "page_size", value: String(FeedEndpointConfig.pageSize))]
        }
    }
    
    var body: Data? {
        switch self {
        default: return nil
        }
    }
}

