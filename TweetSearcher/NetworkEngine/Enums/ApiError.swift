//
//  APIError.swift
//  TweetSearcher
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
