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
    
    func getSearch(query: String, params: [String: String]?, completion: @escaping (Result<MoviesData?, APIError>) -> Void){
        
        guard var urlComponents = URLComponents(string: "\(Constants.URLS.movieBaseURL)\(Constants.MovieControl.search)") else { return }
        
        var queryItems = [URLQueryItem(name: "api_key", value: Constants.URLS.apiKey),
                          URLQueryItem(name: "language", value: "en-US"),
                          URLQueryItem(name: "include_adult", value: "false"),
                          URLQueryItem(name: "query", value: query)
                          ]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return }
        
        
        fetch(with: URLRequest(url: url) , decode: { json -> MoviesData? in
            guard let movieFeedResult = json as? MoviesData else { return  nil }
            return movieFeedResult
        }, completion: completion)
    }
    
}
