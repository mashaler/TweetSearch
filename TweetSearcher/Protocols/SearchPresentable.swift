//
//  SearchPresentable.swift
//  TweetSearcher
//
//  Created by Gontse Ranoto on 2021/11/02.
//

import Foundation

protocol SearchPresentable: AnyObject {
    func showloader()
    func hideLoader()
    func didGetResults()
    func didGetEmptyResults()
}
