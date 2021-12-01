//
//  MoviesDetailPresenter.swift
//  TheMovieDb
//
//  Created by developer on 20/11/21.
//

import Foundation
import UIKit

final class MoviesDetailPresenter: MoviesDetailPresenterProtocol {
    
    var didFetchMovies: Bool = false
    var view: MoviesDetailViewProtocol?
    var interactor: MoviesDetailInteractorInputProtocol?
    var router: MoviesDetailRouterProtocol?
    
    func loadMovieDetail(movie: MovieProtocol) {
        interactor?.fetchDetail(of: movie)
    }
    
    func loadSimilarMoviesFor(movie: MovieProtocol) {
        
        interactor?.fetchSimilarMoviesFor(movie: movie)
    }
    
    func didSelectSimilarMovie(movie: MovieProtocol) {
        if let movieDetailViewController = view as? UIViewController {
            router?.pushDetailViewControllerFrom(view: movieDetailViewController, with: movie)
        }
    }
    
    func loadReviewsOf(movie: MovieProtocol) {
        if let reviewsViewController = view as? UIViewController {
            router?.pushReviewsViewControllerFrom(view: reviewsViewController, with: movie)
        }
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
