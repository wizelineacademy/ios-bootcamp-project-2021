//
//  MoviesDetailPresenterMock.swift
//  TheMovieDbTests
//
//  Created by developer on 30/11/21.
//

import XCTest
@testable import TheMovieDb

class MoviesDetailPresenterMock: XCTestCase, MoviesDetailPresenterProtocol, MoviesDetailInteractorOutputProtocol {
 
    var didFetchMovies: Bool = false
    var view: MoviesDetailViewProtocol?
    var interactor: MoviesDetailInteractorInputProtocol?
    var router: MoviesDetailRouterProtocol?
    
    func loadMovieDetail(movie: MovieProtocol) {
    }
    
    func loadSimilarMoviesFor(movie: MovieProtocol) {

    }
    
    func didSelectSimilarMovie(movie: MovieProtocol) {
        
    }
    
    func didFetchMovieDetail(movieDetail: MovieDetail) {
        didFetchMovies = true
    }
    
    func didFailFetchMovieDetailWith(error: Error) {
        didFetchMovies = false
    }
    
    func didFetchSimilarMoviesFor(movies: MovieList) {
        didFetchMovies = true
    }
    
    func didFailFetchSimilarMoviesWith(error: Error) {
        didFetchMovies = false
    }
    
}
