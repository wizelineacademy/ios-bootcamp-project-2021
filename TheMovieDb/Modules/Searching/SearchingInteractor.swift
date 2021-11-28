//
//  SearchingInteractor.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation

final class SearchingInteractor: SearchingInteractorInputProtocol {
    // MARK: Properties
    weak var presenter: SearchingInteractorOutputProtocol?
    var remoteDatamanager: SearchingRemoteDataManagerInputProtocol?

    func findMovies(_ searchText: String) {
     
            self.remoteDatamanager?.fetchMovies(searchText)
    
    }
}

extension SearchingInteractor: SearchingRemoteDataManagerOutputProtocol {
    func moviesFound(found movies: Movies) {
        let movies = movies.movies
        let viewModel = movies.map { MovieViewModel(movie: $0) }
        presenter?.moviesFound(moviesFound: viewModel)
    }
}
