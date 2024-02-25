//
//  TweetSearcherRepository.swift
//  TweetSearcher
//

import Foundation
import Combine

protocol TweetSearcherRepository {
    func FetchTweetsSearchedFor(searchString: String, completion: @escaping ([SearchResultsDTO]?, Error?) -> ())
}

class TweetSearcherRepositoryImplementation: TweetSearcherRepository {
    private let client: NetworkClient
    private var subscriptions: Set<AnyCancellable> = []
    
    init(_ client: NetworkClient = NetworkClient()) { self.client = client }
    
    func FetchTweetsSearchedFor(searchString: String, completion: @escaping ([SearchResultsDTO]?, Error?) -> ()) {
        NetworkClient.init().publisherForRequest(QuerySearchRecentTweetsRequest(searchString))
            .sink(receiveCompletion: { result in
                switch result {
                case .finished: break;
                case .failure(let error):
                    completion(nil, error)
                }
            }, receiveValue: { [weak self] tweets in
                if let searchResults = self?.populateDTO(tweets) {
                    completion(searchResults, nil)
                } else {
                    completion(nil, nil)
                }
            }).store(in: &subscriptions)
    }
    
    private func populateDTO(_ response: TweetsResponse) -> [SearchResultsDTO]? {
        guard let tweets = response.data else { return nil }
        let results = tweets.map({ SearchResultsDTO(handle: findHandle($0.text),
                                                    tweet: $0.text ?? "",
                                                    isRetweet: $0.text?.contains(AppConstants.retweetText) ?? false) })
        return results
    }
    
    private func findHandle(_ text: String?) -> String {
        guard let text = text, text.contains("@") else { return "" }
        let handle = String(text.split(separator: ":")[0]).replacingOccurrences(of: AppConstants.retweetText, with: "")
        
        return handle
    }
}
