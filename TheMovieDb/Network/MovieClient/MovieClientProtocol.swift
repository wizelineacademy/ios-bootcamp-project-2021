//
//  MovieClientProtocol.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 05/11/21.
//

import Foundation

protocol MovieClientProtocol {

    func getTrendingMovies(page: Int,
                           completion: @escaping (Result<MoviesResult?, APIError>) -> Void)
    
    func getNowPlayingMovies(page: Int,
                             completion: @escaping (Result<MoviesResult?, APIError>) -> Void)
    
    func getPopularMovies(page: Int,
                          completion: @escaping (Result<MoviesResult?, APIError>) -> Void)

    func getTopRatedMovies(page: Int,
                           completion: @escaping (Result<MoviesResult?, APIError>) -> Void)
    
    func getUpcomingMovies(page: Int,
                           completion: @escaping (Result<MoviesResult?, APIError>) -> Void)
    
    func searchByKeyword(searchText: String,
                         completion: @escaping (Result<MoviesResult?, APIError>) -> Void)
    
    func searchMovies(searchText: String,
                      page: Int,
                      completion: @escaping (Result<MoviesResult?, APIError>) -> Void)
    
    func getReviewsMovie(page: Int,
                         movieId: Int,
                         completion: @escaping (Result<MoviesResult?, APIError>) -> Void)
    
    func getSimilarMovies(page: Int,
                          movieId: Int,
                          completion: @escaping (Result<MoviesResult?, APIError>) -> Void)
    
    func getRecommendations(page: Int,
                            movieId: Int,
                            completion: @escaping (Result<MoviesResult?, APIError>) -> Void)
}
