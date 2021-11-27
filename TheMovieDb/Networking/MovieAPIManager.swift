//
//  MovieClient.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 31/10/21.
//

import Foundation

class MovieAPIManager {
    let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    func getFeed<T: Decodable>(from movieFeedType: MovieFeed, searchId: String? = nil, params: [String: String]? = nil, completion: @escaping (Result<T?, APIError>) -> Void) {
        var parameters: [String: String] = [:]
        if params == nil {
            parameters = movieFeedType.defaultParams
        } else {
            parameters = params!
        }
        client.fetch(with: movieFeedType.getRequest(id: searchId, params: parameters), decode: { json -> T? in
            guard let data = json as? T else {
                return nil
            }
            return data
        }, completion: completion)
    }
}
