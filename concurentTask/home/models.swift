//
//  models.swift
//  omartask2
//
//  Created by Omar on 06/06/2026.
//

import Foundation
struct QuotesResponse: Codable {
    let quotes: [Quote]
}

struct Quote: Codable {
    let id: Int
    let quote: String
    let author: String
}




struct PostsResponse: Codable {
    let posts: [Post]
   
}
struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
    let views: Int
}
