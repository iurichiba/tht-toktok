//
//  FeedService.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 04/12/22.
//

import Foundation

// MARK: - Protocols & Extensions
protocol FeedServiceProtocol {
    func getFeed(completion: @escaping (Result<[FeedItem], Error>) -> Void)
}

private extension HTTPRequest {
    static func getFeed() -> Self {
        return HTTPRequest(endpoint: FeedEndpoint.feed, type: .get)
    }
}

// MARK: - Service Implementation
final class FeedService: FeedServiceProtocol {
    private var client: HTTPClientProtocol

    init(client: HTTPClientProtocol) {
        self.client = client
    }

    func getFeed(completion: @escaping (Result<[FeedItem], Error>) -> Void) {
        client.perform(HTTPRequest.getFeed(), completion: completion)
    }
}

// MARK: - Mock Implementation
final class MockFeedService: FeedServiceProtocol {
    func getFeed(completion: @escaping (Result<[FeedItem], Error>) -> Void) {
        let feed = try! JSONHelper().decodeFromFile("feed-preview", type: [FeedItem].self)
        completion(.success(feed))
    }
}
