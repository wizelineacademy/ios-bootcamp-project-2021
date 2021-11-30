//
//  MoviesHomeProtocols.swift
//  TheMovieDb
//
//  Created by developer on 17/11/21.
//

import Foundation
import UIKit

// View -> Presenter
protocol MoviesHomePresenterProtocol: AnyObject {
    var view: MoviesHomeViewProtocol? { get set }
    var interactor: MoviesHomeInteractorInputProtocol? { get set }
    var router: MoviesHomeRouterProtocol? { get set }
    var didFetchMovies: Bool { get set }

    func viewDidLoad()
    func didSelectMovie(movie: MovieProtocol)
}

extension MoviesHomePresenterProtocol {
    var didFetchMovies: Bool { return false}
}
// Presenter -> View
protocol MoviesHomeViewProtocol: AnyObject {
    var presenter: MoviesHomePresenterProtocol? { get set }
    func reloadViewWith(movies: MoviesFeed)
}

// Presenter -> Interactor
protocol MoviesHomeInteractorInputProtocol: AnyObject {
    var presenter: MoviesHomeInteractorOutputProtocol? { get set }
    var apiDataManager: MoviesHomeAPIDataManagerProtocol? { get set }
    func fetchMovies()
}

// Interactor -> Presenter
protocol MoviesHomeInteractorOutputProtocol: AnyObject {
    func fetchMoviesDidFail(with error: Error)
    func moviesDidFetch(movies: MoviesFeed)
}

// Presenter -> Router
protocol MoviesHomeRouterProtocol: AnyObject {
    func pushDetailViewControllerFrom(view: UIViewController, with movie: MovieProtocol)
    func showErrorAlertFrom(view: UIViewController, message: String)
}

// No comunication
protocol MoviesHomeBuilderProtocol {
    static func buildModule() -> UIViewController?
}

protocol MoviesHomeAPIDataManagerProtocol {
    func requestMovies<T: Decodable>(value: T.Type, request: Request, completion: @escaping (Result< T?, Error>) -> Void )
}
