//
//  MoviesHomePresenter.swift
//  TheMovieDb
//
//  Created by developer on 17/11/21.
//

import Foundation
import UIKit

final class MoviesHomePresenter: MoviesHomePresenterProtocol {
    weak var view: MoviesHomeViewProtocol?
    var interactor: MoviesHomeInteractorInputProtocol?
    var router: MoviesHomeRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchMovies()
    }
    
    func didSelectMovie(movie: MovieProtocol) {
        if let moviesHomeViewController = view as? UIViewController {
            router?.pushDetailViewControllerFrom(view: moviesHomeViewController, with: movie)
        }
    }
}

extension MoviesHomePresenter: MoviesHomeInteractorOutputProtocol {
    func moviesDidFetch(movies: MoviesFeed) {
        view?.reloadViewWith(movies: movies)
    }
    
    func fetchMoviesDidFail(with error: Error) {
        
    }
    
}
