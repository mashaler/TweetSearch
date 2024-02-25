//
//  TweetsResponse.swift
//  TweetSearcher
//
//  Created by Gontse Ranoto on 2021/10/30.
//

import Foundation

// MARK: - TweetsResponse
struct TweetsResponse: Decodable {
    let data: [Datum]?
    let meta: Meta?
}

// MARK: - Datum
struct Datum: Decodable {
    let id, text: String?
}

// MARK: - Meta
struct Meta: Decodable {
    let newestID, oldestID: String?
    let resultCount: UInt64?
    let nextToken: String?
}
