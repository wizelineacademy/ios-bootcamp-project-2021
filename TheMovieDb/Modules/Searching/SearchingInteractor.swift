//
//  SearchingInteractor.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation

class SearchingInteractor: SearchingInteractorInputProtocol {
    // MARK: Properties
    weak var presenter: SearchingInteractorOutputProtocol?
    var localDatamanager: SearchingLocalDataManagerInputProtocol?
    var remoteDatamanager: SearchingRemoteDataManagerInputProtocol?

    func findMovies(_ searchText: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.remoteDatamanager?.fetchMovies(searchText)
        }
    }
}

extension SearchingInteractor: SearchingRemoteDataManagerOutputProtocol {
    func moviesFound(found movies: Movies) {
        let movies = movies.movies
        presenter?.moviesFound(moviesFound: movies)
    }
}
