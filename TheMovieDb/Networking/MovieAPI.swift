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
    public func getTrending(completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(typeEndpoint: .trending, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
    
    public func getNowPlaying(completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(typeEndpoint: .nowPlaying, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
    
    public func getPopular(completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(typeEndpoint: .popular, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
    
    public func getTopRated(completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(typeEndpoint: .topRated, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
    
    public func getUpcoming(completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(typeEndpoint: .upcoming, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
    
    public func getByKeyword(completion: @escaping(Result<Search, Error>) -> Void) {
        apiService.getResponse(typeEndpoint: .keyword, completion: { (response: Result<Search, Error>) in
            completion(response)
        })
    }
    
    public func getBySearching(completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(typeEndpoint: .search, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
    
    public func getReviews(completion: @escaping(Result<Reviews, Error>) -> Void) {
        apiService.getResponse(typeEndpoint: .review, completion: { (response: Result<Reviews, Error>) in
            completion(response)
        })
    }
    
    public func getSimilar(completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(typeEndpoint: .similar, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
    
    public func getRecommendations(completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(typeEndpoint: .recommendations, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
}
