//
//  MovieDBServices.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 04/11/21.
//

import Foundation

class MovieDBClient: APIClient, MovieClientProtocol {
  
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        let configuration: URLSessionConfiguration = .default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        self.init(configuration: configuration)
    }
    
    // MARK: - Movie list

    func getMoviesFrom<T>(type: T, page: Int, id: Int, completion: @escaping (Result<MoviesResult<Movie>?, APIError>) -> Void) {
        var request: URLRequest = MovieServices.getTrending(page: page).request
        
        if ((type.self as? SectionMovie) != nil), let typeHomeSections = type.self as? SectionMovie {
            switch typeHomeSections {
            case .trendingMovie:
                request = MovieServices.getTrending(page: page).request
            case .nowPlayingMovies:
                request = MovieServices.getNowPlaying(page: page).request
            case .popularMovies:
                request = MovieServices.getPopular(page: page).request
            case .topRatedMovies:
                request = MovieServices.getTopRated(page: page).request
            case .upcomingMovies:
                request = MovieServices.getUpcoming(page: page).request
            }
        } else if ((type.self as? SectionMovieDetail) != nil), let typeHomeSections = type.self as? SectionMovieDetail {
            switch typeHomeSections {
            case .reccommendattions:
                request = MovieServices.getRecommendations(id: id).request
            case .similar:
                request = MovieServices.getSimilars(id: id).request
            default:
                return
            }
            
        }
        
        fetch(with: request, decode: { json -> MoviesResult<Movie>? in
            guard let movieResult = json as? MoviesResult<Movie> else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    func searchByKeyword(searchText: String, completion: @escaping (Result<MoviesResult<Movie>?, APIError>) -> Void) {
        fetch(with: MovieServices.serachKeyword(searchText: searchText).request, decode: { json -> MoviesResult? in
            guard let movieResult = json as? MoviesResult<Movie> else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    func searchMovies(searchText: String, page: Int,
                      completion: @escaping (Result<MoviesResult<Movie>?, APIError>) -> Void) {
        fetch(with: MovieServices.search(searchText: searchText, page: page).request, decode: { json -> MoviesResult? in
            guard let movieResult = json as? MoviesResult<Movie> else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    func getReviewsMovie(page: Int, movieId: Int, completion: @escaping (Result<MoviesResult<Review>?, APIError>) -> Void) {
        let request = MovieServices.getReviews(id: movieId).request
        fetch(with: request, decode: { json -> MoviesResult<Review>? in
            guard let movieResult = json as? MoviesResult<Review> else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
}
