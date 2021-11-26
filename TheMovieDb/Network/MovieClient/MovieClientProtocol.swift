//
//  MovieClientProtocol.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 05/11/21.
//

import Foundation

protocol MovieClientProtocol {

    func getMoviesFrom(type: SectionMovie,
                       page: Int,
                       id: Int,
                       completion: @escaping (Result<MoviesResult<Movie>?, APIError>) -> Void)
    
    func searchByKeyword(searchText: String,
                         completion: @escaping (Result<MoviesResult<Movie>?, APIError>) -> Void)
    
    func searchMovies(searchText: String,
                      page: Int,
                      completion: @escaping (Result<MoviesResult<Movie>?, APIError>) -> Void)
    
    func getReviewsMovie(page: Int,
                         movieId: Int,
                         completion: @escaping (Result<MoviesResult<Review>?, APIError>) -> Void)
    
}
