//
//  HomeRemoteDataManager.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation

final class HomeRemoteDataManager: HomeRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol?
    private let group = DispatchGroup()
    private var movies: [MovieGroupSections: [Movie]] = [:]
    
    func fetchMovies() {
        fetchData(typeMovieSection: .popular)
        fetchData(typeMovieSection: .upcoming)
        fetchData(typeMovieSection: .topRated)
        fetchData(typeMovieSection: .playingNow)
        fetchData(typeMovieSection: .trending)
        group.notify(queue: .main) {
            self.remoteRequestHandler?.fetchedMovies(self.movies)
        }
    }
    
    private func fetchData(typeMovieSection: MovieGroupSections) {
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
