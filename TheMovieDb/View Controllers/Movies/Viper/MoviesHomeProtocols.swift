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
    
    func viewDidLoad()
    func didSelectMovie(movie: MovieProtocol)
}
// Presenter -> View
protocol MoviesHomeViewProtocol: AnyObject {
    var presenter: MoviesHomePresenterProtocol? { get set }
    func reloadViewWith(movies: MoviesFeed)
}

// Presenter -> Interactor
protocol MoviesHomeInteractorInputProtocol: AnyObject {
    var presenter: MoviesHomeInteractorOutputProtocol? { get set }
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
}

// No comunication
protocol MoviesHomeBuilderProtocol {
    static func buildModule() -> UIViewController?
}
