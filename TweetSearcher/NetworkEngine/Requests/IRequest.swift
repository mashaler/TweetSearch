//
//  Request.swift
//  TweetSearcher
//
//  Created by Gontse Ranoto on 2021/10/27.
//

import Foundation

protocol IRequest {
    associatedtype response
    var method: HttpVerb { get }
    var path: String { get }
    var body: Data? { get }
    
    func handleResponse(response: Data) throws -> response
}


