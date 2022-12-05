//
//  FeedItem.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 04/12/22.
//

import Foundation

struct FeedItem: Codable {
    let id: Int
    let title: String
    let user: User
    let videoUrl: URL
}
