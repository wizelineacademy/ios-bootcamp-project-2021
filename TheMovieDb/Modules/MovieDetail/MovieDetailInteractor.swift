//
//  MovieDetailInteractor.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation

class MovieDetailInteractor: MovieDetailInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: MovieDetailInteractorOutputProtocol?
    var localDatamanager: MovieDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: MovieDetailRemoteDataManagerInputProtocol?
    
    func getRelatedMovies() {
        remoteDatamanager?.fetchRelatedMovies()
    }
    
}

extension MovieDetailInteractor: MovieDetailRemoteDataManagerOutputProtocol {
    func relatedMoviesFound(_ relatedMovies: [MovieDetailSections: [Movie]]) {
        presenter?.moviesFromInteractor(relatedMovies)
    }
    
}
