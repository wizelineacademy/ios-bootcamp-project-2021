//
//  MovieClient.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 18/11/21.
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
    
    func getFeed(from movieFeedType: MovieFeed, completion: @escaping (Result<MoviesData?, APIError>) -> Void) {
        fetch(with: movieFeedType.request , decode: { json -> MoviesData? in
            guard let movieFeedResult = json as? MoviesData else { return  nil }
            return movieFeedResult
        }, completion: completion)
    }
    
}
