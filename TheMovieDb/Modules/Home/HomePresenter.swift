//
//  HomePresenter.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation

class HomePresenter {
    
    // MARK: Properties
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?
    
}

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        interactor?.getMovies()
    }
    
    func showMovie(_ movie: Movie) {
        guard let view = view else { return }
        router?.showMovie(from: view, with: movie)
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func onError(errorMessage: String) {
        view?.showErrorMessage(withMessage: errorMessage)
    }
    
    func moviesObtained(_ movies: [MovieGroupSections: [Movie]]) {
        view?.showMovies(movies)
    }
}
