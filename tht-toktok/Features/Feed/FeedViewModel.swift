//
//  FeedViewModel.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 04/12/22.
//

import Foundation

enum FeedViewState {
    case loading
    case feed([FeedItem])
}

final class FeedViewModel {
    private var service: FeedServiceProtocol
    
    @Published var state: FeedViewState = .loading
    @Published var data = [FeedItem]()
    
    init(service: FeedServiceProtocol) {
        self.service = service
    }
    
    func loadFeed() {
        service.getFeed { [weak self] result in
            switch result {
            case .success(let feed):
                self?.data = feed
                self?.state = .feed(feed)
            case .failure(let error):
                print(error) // TODO: show error and reload button
            }
        }
    }
    
    func heartTapped(forFeedItemAt index: Int) {
        self.data[index].heartCount += 1
    }
    
    func flameTapped(forFeedItemAt index: Int) {
        self.data[index].flameCount += 1
    }
    
}

