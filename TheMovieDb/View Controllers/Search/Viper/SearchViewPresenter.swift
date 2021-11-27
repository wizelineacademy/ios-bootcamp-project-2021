//
//  SearchViewPresenter.swift
//  TheMovieDb
//
//  Created by developer on 26/11/21.
//

import Foundation

final class SearchViewPresenter: SearchViewPresenterProtocol {
    
    
   
    var view: SearchViewProtocol?
    var interactor: SearchViewInteractorInputProtocol?
    var router: SearchViewRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchInitialMovies(topic: .topRated)
    }
    
    func search(text: String) {
        interactor?.fetchSearchedMovies(text: text)
    }
}

extension SearchViewPresenter: SearchViewInteractorOutputProtocol {
    func didFetchSearchedMovies(movieList: MovieList) {
        self.view?.reloadViewWithMovies(movies: movieList)

    }
    
    func fetchSearchedMoviesDidFail(error: Error) {
        
    }
    
    func fetchMoviesDidFail(error: Error) {
        
    }
    
    func didFetchMovies(movieList: MovieList) {
        self.view?.reloadViewWithMovies(movies: movieList)
    }
}
