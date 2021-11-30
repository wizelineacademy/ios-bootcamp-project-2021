//
//  MoviesDetailPresenterMock.swift
//  TheMovieDbTests
//
//  Created by developer on 30/11/21.
//

import XCTest
@testable import TheMovieDb

class MoviesDetailPresenterMock: XCTestCase, MoviesDetailPresenterProtocol {
    var view: MoviesDetailViewProtocol?
    
    var interactor: MoviesDetailInteractorInputProtocol?
    
    var router: MoviesDetailRouterProtocol?
    
    func loadMovieDetail(movie: MovieProtocol) {
        
    }
    
    func loadSimilarMoviesFor(movie: MovieProtocol) {
    
    }
    
    func didSelectSimilarMovie(movie: MovieProtocol) {
        
    }
    


}
