//
//  MovieDBServices.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 04/11/21.
//

import Foundation

class MovieDBClient: APIClient, MovieClientProtocol {

    let session: URLSession

    // MARK: - Initializers
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        let configuration: URLSessionConfiguration = .default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        self.init(configuration: configuration)
    }
    
    // MARK: - Movie list

    func getTrendingMovies(page: Int, completion: @escaping (Result<MoviesResult?, APIError>) -> Void) {
        let request = MovieServices.getTrending(page: page).request
        fetch(with: request, decode: { json -> MoviesResult? in
            guard let movieResult = json as? MoviesResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    func getNowPlayingMovies(page: Int, completion: @escaping (Result<MoviesResult?, APIError>) -> Void) {
        let request = MovieServices.getNowPlaying(page: page).request
        fetch(with: request, decode: { json -> MoviesResult? in
            guard let movieResult = json as? MoviesResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    func getPopularMovies(page: Int, completion: @escaping (Result<MoviesResult?, APIError>) -> Void) {
        let request = MovieServices.getPopular(page: page).request
        fetch(with: request, decode: { json -> MoviesResult? in
            guard let movieResult = json as? MoviesResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    func getTopRatedMovies(page: Int, completion: @escaping (Result<MoviesResult?, APIError>) -> Void) {
        let request = MovieServices.getTopRated(page: page).request
        fetch(with: request, decode: { json -> MoviesResult? in
            guard let movieResult = json as? MoviesResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    func getUpcomingMovies(page: Int, completion: @escaping (Result<MoviesResult?, APIError>) -> Void) {
        let request = MovieServices.getUpcoming(page: page).request
        fetch(with: request, decode: { json -> MoviesResult? in
            guard let movieResult = json as? MoviesResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    func searchByKeyword(searchText: String, completion: @escaping (Result<MoviesResult?, APIError>) -> Void) {
        fetch(with: MovieServices.serachKeyword(searchText: searchText).request, decode: { json -> MoviesResult? in
            guard let movieResult = json as? MoviesResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    func searchMovies(searchText: String, page: Int,
                      completion: @escaping (Result<MoviesResult?, APIError>) -> Void) {
        fetch(with: MovieServices.search(searchText: searchText, page: page).request, decode: { json -> MoviesResult? in
            guard let movieResult = json as? MoviesResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    func getReviewsMovie(page: Int, movieId: Int, completion: @escaping (Result<MoviesResult?, APIError>) -> Void) {
        let request = MovieServices.getReviews(page: page, id: movieId).request
        fetch(with: request, decode: { json -> MoviesResult? in
            guard let movieResult = json as? MoviesResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    func getSimilarMovies(page: Int, movieId: Int,
                          completion: @escaping (Result<MoviesResult?, APIError>) -> Void) {
        let request = MovieServices.getSimilars(page: page, id: movieId).request
        fetch(with: request, decode: { json -> MoviesResult? in
            guard let movieResult = json as? MoviesResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    func getRecommendations(page: Int, movieId: Int, completion: @escaping (Result<MoviesResult?, APIError>) -> Void) {
        let request = MovieServices.getRecommendations(page: page, id: movieId).request
        fetch(with: request, decode: { json -> MoviesResult? in
            guard let movieResult = json as? MoviesResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
}
