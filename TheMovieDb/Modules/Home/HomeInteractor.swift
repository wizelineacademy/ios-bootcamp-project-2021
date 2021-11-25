//
//  HomeInteractor.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation

class HomeInteractor: HomeInteractorInputProtocol {
    // MARK: Properties
    weak var presenter: HomeInteractorOutputProtocol?
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol?

    func getMovies() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.remoteDatamanager?.fetchMovies()
        }
  
    }
    
}

extension HomeInteractor: HomeRemoteDataManagerOutputProtocol {
    func fetchedMovies(_ movies: [MovieGroupSections: [Movie]]) {
        presenter?.moviesObtained(movies)
    }
    
}
