//
//  Environment.swift
//  TweetSearcher
//

import Foundation

struct Environment { var baseUrl: URL }
extension Environment { static let production = Environment(baseUrl: URL(string: "https://api.twitter.com/2")!) }
