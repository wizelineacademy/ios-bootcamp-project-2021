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
    var movies: [MovieDetailSections: [Movie]] = [:]
    func fetchRelatedMovies() {
        fetchData(typeMovieSection: .recommendations)
        fetchData(typeMovieSection: .similar)
        group.notify(queue: .main) {
            self.remoteRequestHandler?.relatedMoviesFound(self.movies)
        }
    }
    
    private func fetchData(typeMovieSection: MovieDetailSections) {
        group.enter()
        MovieAPI.shared.fetchData(endPoint: typeMovieSection.path, completion: {(response: Result<Movies, Error>) in
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
