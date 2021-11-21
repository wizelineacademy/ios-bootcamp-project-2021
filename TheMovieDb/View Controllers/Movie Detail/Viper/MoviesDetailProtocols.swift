//
//  MoviesDetailProtocols.swift
//  TheMovieDb
//
//  Created by developer on 20/11/21.
//

import Foundation
import UIKit

// Presenter
protocol MoviesDetailPresenterProtocol {
    var view: MoviesDetailViewProtocol? { get set }
    var interactor: MoviesDetailInteractorInputProtocol? { get set }
    var router: MoviesDetailRouterProtocol? { get set }
    func loadMovieDetail(movie: MovieProtocol)
    func loadSimilarMoviesFor(movie: MovieProtocol)
    
}

// View
protocol MoviesDetailViewProtocol {
    var presenter: MoviesDetailPresenterProtocol? { get set }
    func showDetailOf(movie: MovieDetailProtocol)
    func displaySimilarMovies(list: MovieList)
}

// Interractor
protocol MoviesDetailInteractorInputProtocol {
    var presenter: MoviesDetailInteractorOutputProtocol? { get set }
    func fetchDetail(of movie: MovieProtocol)
    func fetchSimilarMoviesFor(movie: MovieProtocol)
}

protocol MoviesDetailInteractorOutputProtocol {
    // Only methods the presenter will implement
    func didFetchMovieDetail(movieDetail: MovieDetail)
    func didFailFetchMovieDetailWith(error: Error)
    func didFetchSimilarMoviesFor(movies: MovieList)
    func didFailFetchSimilarMoviesWith(error: Error)
}

// Builder
protocol MoviesDetailBuilderProtocol {
    static func buildModuleWith(movie: MovieProtocol) -> UIViewController?
}

protocol MoviesDetailRouterProtocol {

}
