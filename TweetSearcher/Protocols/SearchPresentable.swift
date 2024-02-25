//
//  SearchPresentable.swift
//  TweetSearcher
//

import Foundation

protocol SearchPresentable: AnyObject {
    func showloader()
    func hideLoader()
    func didGetResults()
    func didGetEmptyResults()
}
