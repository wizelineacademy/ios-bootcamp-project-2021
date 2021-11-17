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
    var service: APIMoviesProtocol?
    private let defaultParameters = APIParameters()
    private let group = DispatchGroup()
    private var movies: [MovieGroupSections: [Movie]] = [:]
    
    func fetchMovies() {
        MovieGroupSections.allCases.forEach { fetchData(typeMovieSection: $0) }
        group.notify(queue: .main) {
            self.remoteRequestHandler?.fetchedMovies(self.movies)
        }
    }
    
    private func fetchData(typeMovieSection: MovieGroupSections) {
        group.enter()
        service?.fetchData(endPoint: typeMovieSection.path, with: defaultParameters, completion: {(response: Result<Movies, Error>) in
            switch response {
            case .failure(let error):
                Log.networkLayer(error).description
            case .success(let res):
                self.movies[typeMovieSection] = res.movies
            }
            self.group.leave()
        })
    }
}
