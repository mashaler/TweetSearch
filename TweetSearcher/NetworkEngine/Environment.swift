//
//  Environment.swift
//  TweetSearcher
//
//  Created by Gontse Ranoto on 2021/10/27.
//

import Foundation

struct Environment { var baseUrl: URL }
extension Environment { static let production = Environment(baseUrl: URL(string: "https://api.twitter.com/2")!) }
