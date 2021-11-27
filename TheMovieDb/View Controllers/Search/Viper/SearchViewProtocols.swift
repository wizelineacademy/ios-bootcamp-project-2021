//
//  SearchViewProtocols.swift
//  TheMovieDb
//
//  Created by developer on 25/11/21.
//

import Foundation
import UIKit

protocol SearchViewProtocol {
    var presenter: SearchViewPresenterProtocol? { get set }
    func reloadViewWithMovies(movies: MovieList)
}

protocol SearchViewPresenterProtocol {
    var view: SearchViewProtocol? { get set }
    var interactor: SearchViewInteractorInputProtocol? { get set }
    var router: SearchViewRouterProtocol? { get set }
    func viewDidLoad()
    func search(text: String)
    func didSelectMovie(movie: MovieProtocol)
    
}

protocol SearchViewInteractorInputProtocol {
    var presenter: SearchViewInteractorOutputProtocol? { get set }
    var apiDataManager: SearchViewAPIDataManagerProtocol? { get set }
    func fetchInitialMovies(topic: Topic)
    func fetchSearchedMovies(text: String)

}

protocol SearchViewInteractorOutputProtocol {
    func didFetchMovies(movieList: MovieList)
    func fetchMoviesDidFail(error: Error)
    func didFetchSearchedMovies(movieList: MovieList)
    func fetchSearchedMoviesDidFail(error: Error)

}

protocol SearchViewRouterProtocol {
    func showMovieDetailFrom(view: UIViewController, movie: MovieProtocol)
}

protocol SearchViewBuilderProtocol {
    static func buildModule() -> UIViewController?
}

protocol SearchViewAPIDataManagerProtocol {
    func requestMovies<T: Decodable>(value: T.Type, request: Request, completion: @escaping (Result< T?, Error>) -> Void )
}
