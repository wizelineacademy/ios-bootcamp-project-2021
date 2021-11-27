//
//  MovieDetailProtocols.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Combine
import UIKit

protocol MovieDetailViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func showRealatedMoviews(_ relatedMovies: [MovieDetailSections: [Movie]])
    func setMovie(_ movie: Movie)
    func showErrorMessage(withMessage: String)
}

protocol MovieDetailRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    func showReviews(from view: MovieDetailViewProtocol, with movie: Movie)
    func showMovie(from view: MovieDetailViewProtocol, with movie: Movie)
}

protocol MovieDetailBuilderProtocol: AnyObject {
    // BUILDER
    static func createModule(with movie: Movie) -> UIViewController
}

typealias MovieDetailPresenterInteractorProtocol = MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol
protocol MovieDetailPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInteractorInputProtocol? { get set }
    var router: MovieDetailRouterProtocol? { get set }
    
    func viewDidLoad()
    func showReviews(_ movie: Movie)
    func showMovie(_ movie: Movie)
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func moviesFromInteractor(_ relatedMovies: [MovieDetailSections: [Movie]])
    func movieFromInteractor(with movie: Movie)
    func onError(errorMessage: String)
}

protocol MovieDetailInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    func getRelatedMovies()
    func getMovie()
}

protocol MovieDetailWorkerProtocol {
    // WORKER -> INTERACTOR
    func fetchMovies(typeMovieSection: MovieDetailSections, with paremeters: APIParameters) -> AnyPublisher<Movies, APIRequestError>
}
