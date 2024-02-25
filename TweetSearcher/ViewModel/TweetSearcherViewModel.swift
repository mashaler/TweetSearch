//
//  TweetSearcherViewModel.swift
//  TweetSearcher
//
//  Created by Gontse Ranoto on 2021/10/29.
//

import Foundation
import Combine

class TweetSearcherViewModel {
    private let repository: TweetSearcherRepository
    private let searchPresentable: SearchPresentable
    private var tweets: [SearchResultsDTO]?
    
    @Published private(set) var error: Error?

    init(_ searchPresentable: SearchPresentable, repository: TweetSearcherRepository = TweetSearcherRepositoryImplementation()) {
        self.repository = repository
        self.searchPresentable = searchPresentable
    }
    
    func getTweets(_ searchString: String) {
        searchPresentable.showloader()
        repository.FetchTweetsSearchedFor(searchString: searchString, completion: { [weak self] tweets, error in
            self?.searchPresentable.hideLoader()
            if let tweets = tweets {
                self?.searchPresentable.didGetResults()
                self?.tweets = tweets
            } else if tweets == nil && error == nil {
                self?.searchPresentable.didGetEmptyResults()
            } else { self?.error = error }
        })
    }
    
    func getTweetForRow(_ row: Int) -> SearchResultsDTO? { tweets?[row] }
    func getRowCount() -> Int { tweets?.count ?? 0 }
}
