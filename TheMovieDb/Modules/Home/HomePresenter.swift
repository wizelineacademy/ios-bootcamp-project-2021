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
    var wireFrame: HomeWireFrameProtocol?
    
}

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        interactor?.getMovies()
    }
    
    func showMovie(_ movie: Movie) {
        guard let view = view else { return }
        wireFrame?.showMovie(from: view, with: movie)
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func moviesObtained(_ movies: [MovieGroupSections: [Movie]]) {
        view?.showMovies(movies)
    }
}
