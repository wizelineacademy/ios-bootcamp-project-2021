//
//  MovieAPI.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 28/10/21.
//

import Foundation

class MovieAPI: APISearchProtocol, APIMoviesProtocol, APIReviewsProtocol {
    
    static let shared = MovieAPI()
    private let apiService = APIService()
    
    // MARK: - Todo: reduce code in the functions, repeated code
    public func getTrending(with parameters: APIParameters = APIParameters(), completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(endPoint: .trending, with: parameters, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
    
    public func getNowPlaying(with parameters: APIParameters = APIParameters(), completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(endPoint: .nowPlaying, with: parameters, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
    
    public func getPopular(with parameters: APIParameters = APIParameters(), completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(endPoint: .popular, with: parameters, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
    
    public func getTopRated(with parameters: APIParameters = APIParameters(), completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(endPoint: .topRated, with: parameters, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
    
    public func getUpcoming(with parameters: APIParameters = APIParameters(), completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(endPoint: .upcoming, with: parameters, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
    
    public func getByKeyword(with parameters: APIParameters = APIParameters(), completion: @escaping(Result<Search, Error>) -> Void) {
        apiService.getResponse(endPoint: .keyword, with: parameters, completion: { (response: Result<Search, Error>) in
            completion(response)
        })
    }
    
    public func getBySearching(with parameters: APIParameters = APIParameters(), completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(endPoint: .search, with: parameters, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
    
    public func getReviews(with parameters: APIParameters = APIParameters(), completion: @escaping(Result<Reviews, Error>) -> Void) {
        apiService.getResponse(endPoint: .review, with: parameters, completion: { (response: Result<Reviews, Error>) in
            completion(response)
        })
    }
    
    public func getSimilar(with parameters: APIParameters = APIParameters(), completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(endPoint: .similar, with: parameters, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
    
    public func getRecommendations(with parameters: APIParameters = APIParameters(), completion: @escaping(Result<Movies, Error>) -> Void) {
        apiService.getResponse(endPoint: .recommendations, with: parameters, completion: { (response: Result<Movies, Error>) in
            completion(response)
        })
    }
}
