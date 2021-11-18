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
    var wireFrame: MovieDetailWireFrameProtocol?
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
   
    func viewDidLoad() {
        interactor?.getRelatedMovies()
    }
    
    func setMovie(_ movie: Movie) {
        view?.setMovie(movie)
    }
    
    func showReviews(_ movie: Movie) {
        guard let view = view else { return }
        wireFrame?.showReviews(from: view, with: movie)
    }
    
    func showMovie(_ movie: Movie) {
        guard let view = view else { return }
        wireFrame?.showMovie(from: view, with: movie)
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func moviesFromInteractor(_ relatedMovies: [MovieDetailSections: [Movie]]) {
        view?.showRealatedMoviews(relatedMovies)
    }
    
}
