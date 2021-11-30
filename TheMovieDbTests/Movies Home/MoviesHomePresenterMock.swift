//
//  MoviesHomePresenterMock.swift
//  TheMovieDbTests
//
//  Created by developer on 29/11/21.
//

import XCTest
@testable import TheMovieDb

class MoviesHomePresenterMock: XCTestCase, MoviesHomePresenterProtocol, MoviesHomeInteractorOutputProtocol {
    var didFetchMovies: Bool = false
    func fetchMoviesDidFail(with error: Error) {
        didFetchMovies = false
    }
    
    func moviesDidFetch(movies: MoviesFeed) {
        didFetchMovies = true
    }
    
    var view: MoviesHomeViewProtocol?
    
    var interactor: MoviesHomeInteractorInputProtocol?
    
    var router: MoviesHomeRouterProtocol?
    
    func viewDidLoad() {
        
    }
    
    func didSelectMovie(movie: MovieProtocol) {
        
    }

}
