//
//  SearchingPresenter.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation

final class SearchingPresenter {
    
    // MARK: Properties
    weak var view: SearchingViewProtocol?
    var interactor: SearchingInteractorInputProtocol?
    var router: SearchingRouterProtocol?
    
}

extension SearchingPresenter: SearchingPresenterProtocol {
    func showMovie(_ movie: Movie) {
        guard let view = view else { return }
        router?.showMovieDetail(from: view, with: movie)
    }
    
    func searchMovies(_ searchText: String) {
        view?.showSpinnerView()
        view?.removeMessageSearchesNotFound()
        interactor?.findMovies(searchText)
    }
}

extension SearchingPresenter: SearchingInteractorOutputProtocol {
    func noSearchesFound(with message: String) {
        view?.stopSpinnerView()
        view?.showMessageNoSearchesFound(with: message)
    }
    
    func onError(errorMessage: String) {
        view?.showErrorMessage(withMessage: errorMessage)
        view?.stopSpinnerView()
    }
    
    func moviesFound(moviesFound: [MovieViewModel]) {
        view?.showMoviesResults(moviesFound)
        view?.stopSpinnerView()
    }

}
