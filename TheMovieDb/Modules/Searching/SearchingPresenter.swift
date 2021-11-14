//
//  SearchingPresenter.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation

class SearchingPresenter {
    
    // MARK: Properties
    weak var view: SearchingViewProtocol?
    var interactor: SearchingInteractorInputProtocol?
    var wireFrame: SearchingWireFrameProtocol?
    
}

extension SearchingPresenter: SearchingPresenterProtocol {
    func showMovie(_ movie: Movie) {
        guard let view = view else { return }
        wireFrame?.showMovieDetail(from: view, with: movie)
    }
    
    func viewDidLoad() {
        // configure load previous searching
    }
    
    func searchMovies(_ searchText: String) {
        view?.showSpinnerView()
        interactor?.findMovies(searchText)
    }
}

extension SearchingPresenter: SearchingInteractorOutputProtocol {
    func moviesFound(moviesFound: [Movie]) {
        view?.stopSpinnerView()
        view?.showMoviesResults(moviesFound)
    }

}
