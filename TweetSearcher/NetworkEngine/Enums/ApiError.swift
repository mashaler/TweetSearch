//
//  APIError.swift
//  TweetSearcher
//
//  Created by Gontse Ranoto on 2021/10/27.
//

import Foundation

enum ApiError: Error {
    case requestFailed(Int)
    case noTweetFound
}

// MARK: - Localized Error

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .requestFailed(_):
            return  AppConstants.failedRequest
        case .noTweetFound:
            return AppConstants.noTweet
        }
    }
}
