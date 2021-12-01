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
    func didSelectSimilarMovie(movie: MovieProtocol)
    func loadReviewsOf(movie: MovieProtocol)
    var didFetchMovies: Bool { get set }
    
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
    var apiDataManager: MoviesDetailAPIDataManagerProtocol? { get set }
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
    func pushDetailViewControllerFrom(view: UIViewController, with movie: MovieProtocol)
    func pushReviewsViewControllerFrom(view: UIViewController, with movie: MovieProtocol)
}

protocol MoviesDetailAPIDataManagerProtocol {
    func requestMovieDetail<T: Decodable>(value: T.Type, request: Request, completion: @escaping (Result< T?, Error>) -> Void )
    func requestSimilarMovies<T: Decodable>(value: T.Type, request: Request, completion: @escaping (Result< T?, Error>) -> Void )
    
}
