//
//  TweetSearchRequests.swift
//  TweetSearcher
//
//  Created by Gontse Ranoto on 2021/10/27.
//

import Foundation

struct QuerySearchRecentTweetsRequest: IRequest {
    private let searchString: String
    
    typealias response = TweetsResponse
    var method: HttpVerb { return .GET }
    var path: String { return "tweets/search/recent?query=\(searchString)" }
    var additionalHeaders: [String : String] { return [:] }
    var body: Data? { return nil }
    
    init(_ searchString: String) { self.searchString = searchString }
    
    func handleResponse(response: Data) throws -> TweetsResponse {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(TweetsResponse.self, from: response)
    }
}
