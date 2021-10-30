//
//  MovieAPI.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 28/10/21.
//

import Foundation

class MovieAPI {
    static let shared = MovieAPI()
    private let apiService = APIService()
    
    // MARK: - Todo: reduce code in the functions, repeated code
    public func getTrending(completion: @escaping([Movie]?) -> Void) {
        apiService.getResponse(typeEndpoint: .trending, completion: { (movies: Movies?, _) in
            completion(movies?.movies)
        })
        
    }
    
    public func getNowPlaying(completion: @escaping([Movie]?) -> Void) {
        apiService.getResponse(typeEndpoint: .nowPlaying, completion: { (movies: Movies?, _) in
            completion(movies?.movies)
        })
    }
    
    public func getPopular(completion: @escaping([Movie]?) -> Void) {
        apiService.getResponse(typeEndpoint: .popular, completion: { (movies: Movies?, _) in
            completion(movies?.movies)
        })
    }
    
    public func getTopRated(completion: @escaping([Movie]?) -> Void) {
        apiService.getResponse(typeEndpoint: .topRated, completion: { (movies: Movies?, _) in
            completion(movies?.movies)
        })
    }
    
    public func getUpcoming(completion: @escaping([Movie]?) -> Void) {
        apiService.getResponse(typeEndpoint: .upcoming, completion: { (movies: Movies?, _) in
            completion(movies?.movies)
        })
    }
    
    public func getByKeyword(completion: @escaping([Result]?) -> Void) {
        apiService.getResponse(typeEndpoint: .keyword, completion: { (results: Search?, _) in
            completion(results?.results)
        })
    }
    
    public func getBySearching(completion: @escaping([Movie]?) -> Void) {
        apiService.getResponse(typeEndpoint: .search, completion: { (movies: Movies?, _) in
            completion(movies?.movies)
        })
    }
    
    public func getReviews(completion: @escaping([Review]?) -> Void) {
        apiService.getResponse(typeEndpoint: .review, completion: { (reviews: Reviews?, _) in
            completion(reviews?.reviews)
        })
    }
    
    public func getSimilar(completion: @escaping([Movie]?) -> Void) {
        apiService.getResponse(typeEndpoint: .similar, completion: { (movies: Movies?, _) in
            completion(movies?.movies)
        })
    }
    
    public func getRecommendations(completion: @escaping([Movie]?) -> Void) {
        apiService.getResponse(typeEndpoint: .recommendations, completion: { (movies: Movies?, _) in
            completion(movies?.movies)
        })
    }
}
