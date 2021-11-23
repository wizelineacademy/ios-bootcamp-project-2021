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
    
    func getFeed(from moviewFeedType: MovieFeed, searchId: String? = nil, params: [String: String], completion: @escaping (Result<MovieListResults?, APIError>) -> Void) {
        client.fetch(with: moviewFeedType.getRequest(id: searchId, params: params), decode: { [weak self] json -> MovieListResults? in
            return self?.getJSONData(data: json)
        }, completion: completion)
    }
    
    func getConfiguration(completion: @escaping (Result<ConfigurationWelcome?, APIError>) -> Void) {
        let configuration = MovieFeed.configuration
        client.fetch(with: configuration.getRequest(id: nil, params: configuration.defaultParams), decode: {  [weak self] json -> ConfigurationWelcome? in
            return self?.getJSONData(data: json)
        }, completion: completion)
    }
    
    private func getJSONData<T: Decodable>(data: Decodable) -> T? {
        guard let data = data as? T else {
            return nil
        }
        return data
    }
}
