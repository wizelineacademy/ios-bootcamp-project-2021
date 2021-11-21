//
//  MoviesDetailPresenter.swift
//  TheMovieDb
//
//  Created by developer on 20/11/21.
//

import Foundation

final class MoviesDetailPresenter: MoviesDetailPresenterProtocol {
   
    

    var view: MoviesDetailViewProtocol?
    var interactor: MoviesDetailInteractorInputProtocol?
    var router: MoviesDetailRouterProtocol?
    
    func loadMovieDetail(movie: MovieProtocol) {
        interactor?.fetchDetail(of: movie)
    }
    
    func loadSimilarMoviesFor(movie: MovieProtocol) {
      
        interactor?.fetchSimilarMoviesFor(movie: movie)
    }
    
}

extension MoviesDetailPresenter: MoviesDetailInteractorOutputProtocol {
    func didFailFetchSimilarMoviesWith(error: Error) {
        print(error)
    }
    
    func didFetchSimilarMoviesFor(movies: MovieList) {
        view?.displaySimilarMovies(list: movies)
    }
    
    func didFailFetchMovieDetailWith(error: Error) {
        print(error)
    }
    
    func didFetchMovieDetail(movieDetail: MovieDetail) {
        view?.showDetailOf(movie: movieDetail)
    }
    
   
    
}
