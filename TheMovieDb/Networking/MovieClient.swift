//
//  MovieClient.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 31/10/21.
//

import Foundation

class MovieClient: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }
    
    func getFeed(from moviewFeedType: MovieFeed, searchId: String? = nil, params: [String: String], completion: @escaping (Result<MovieList?, APIError>) -> Void) {
        fetch(with: moviewFeedType.getRequest(id: searchId, params: params), decode: { json -> MovieList? in
            guard let movieList = json as? MovieList else {
                return nil
            }
            return movieList
        }, completion: completion)
    }
}
