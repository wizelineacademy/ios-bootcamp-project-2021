//
//  MovieDetailPresenter.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation

class MovieDetailPresenter {
    
    // MARK: Properties
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorInputProtocol?
    var router: MovieDetailRouterProtocol?
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
   
    func viewDidLoad() {
        interactor?.getRelatedMovies()
        interactor?.getMovie()
    }
    
    func showReviews(_ movie: Movie) {
        guard let view = view else { return }
        router?.showReviews(from: view, with: movie)
    }
    
    func showCast(_ movie: Movie) {
        guard let view = view else { return }
        router?.showCast(from: view, with: movie)
    }
    
    func showMovie(_ movie: Movie) {
        guard let view = view else { return }
        router?.showMovie(from: view, with: movie)
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func onError(errorMessage: String) {
        view?.showErrorMessage(withMessage: errorMessage)
    }
    
    func movieFromInteractor(with movie: Movie) {
        view?.setMovie(movie)
    }
    
    func moviesFromInteractor(_ relatedMovies: [MovieDetailSections: [Movie]]) {
        view?.showRelatedMovies(relatedMovies)
    }
    
}
