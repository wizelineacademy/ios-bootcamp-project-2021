//
//  MovieDetailRemoteDataManager.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation

class MovieDetailRemoteDataManager: MovieDetailRemoteDataManagerInputProtocol {
    var remoteRequestHandler: MovieDetailRemoteDataManagerOutputProtocol?
    private let group = DispatchGroup()
    private let defaultParameters = APIParameters()
    var movies: [MovieDetailSections: [Movie]] = [:]
    var service: APIMoviesProtocol?
    
    func fetchRelatedMovies() {
        MovieDetailSections.allCases.forEach { fetchData(typeMovieSection: $0) }
        group.notify(queue: .main) {
            self.remoteRequestHandler?.relatedMoviesFound(self.movies)
        }
    }
    
    private func fetchData(typeMovieSection: MovieDetailSections) {
        group.enter()
        service?.fetchData(endPoint: typeMovieSection.path, with: defaultParameters, completion: {(response: Result<Movies, Error>) in
            switch response {
            case .failure(let error):
                debugPrint(error)
            case .success(let res):
                self.movies[typeMovieSection] = res.movies
            }
            self.group.leave()
        })
    }
    
}
