//
//  MovieDetailProtocolsMVVM.swift
//  TheMovieDb
//
//  Created by Angel Coronado Quintero on 12/01/22.
//

import Foundation
import UIKit

protocol MovieDetailViewModelProtocol {
    var movie: MovieProtocol { get set }
    var movieDetail: MovieDetailProtocol? { get set }
    var similarMovies: MovieList? { get set }
    var apiDataManager: MoviesDetailAPIDataManagerProtocol? { get set }
    func fetchDetailWith(movie: MovieProtocol)
    var didFetchMovieDetail: ((_ movieDetal: MovieDetailProtocol) -> Void )? { get set }
    var didFailFetchingMovieDetail: ((_ error: Error) -> Void)? { get set }
    func fetchSimiliarMoviesWith(movie: MovieProtocol)
    var didFetchSimilarMovies: ((_ movies: MovieList) -> Void)? { get set }
    var didFailFetchingSimilarMovies: ((_ error: Error) -> Void)? { get set }
    func fetchAllDetailData()
    func fetchDetail()
    func fetchSimiliar()
    var router: MoviesDetailRouterProtocol? { get set }
    func showMovieDetailWith(movie: MovieProtocol, from view: UIViewController)
    func showMovieReviews(view: UIViewController)
    func getScreenTitle() -> String
}

protocol MovieDetailViewProtocol {
    var viewModel: MovieDetailViewModelProtocol? { get set }
}
