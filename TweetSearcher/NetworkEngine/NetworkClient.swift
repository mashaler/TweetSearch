//
//  Client.swift
//  TweetSearcher
//

import Foundation
import Combine

struct NetworkClient {
    private let urlSession: URLSession
    private let environment: Environment
    
    init(urlSession: URLSession = .shared, environment: Environment = .production) {
        self.urlSession = urlSession
        self.environment = environment
    }
    
    func publisherForRequest<T: IRequest>(_ request: T) -> AnyPublisher<T.response, Error> {
        let url = environment.baseUrl.appendingPathComponent(request.path)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.url = URL(string: urlRequest.url?.absoluteString.removingPercentEncoding ?? "")
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("keep-alive", forHTTPHeaderField: "Connection")
        addSecreteHeader(&urlRequest)
        
        let publisher = urlSession.dataTaskPublisher(for: urlRequest).tryMap { data, response in
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                throw ApiError.requestFailed(statusCode)
            }
            return data
        }
        .tryMap { responseData -> T.response in
            try (request.handleResponse(response: responseData))
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
        
        return publisher
    }
    
    @inline(__always)
    private func addSecreteHeader(_ urlRequest: inout URLRequest) {
        urlRequest.addValue("Bearer AAAAAAAAAAAAAAAAAAAAALWlVAEAAAAA5riAVbsMAwcxAGB5tw047iKhPwQ%3DpwudycLdAVSePFpYZLyB2GKhgek3vYsk9N0QViQoPjJJttqYOG", forHTTPHeaderField: "Authorization")
    }
}
