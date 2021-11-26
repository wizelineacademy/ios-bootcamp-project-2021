//
//  HomeRemoteDataManager.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import Combine
final class HomeRemoteDataManager: HomeRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol?
    private let service: APIMoviesProtocol
    private let defaultParameters = APIParameters()
    private let group = DispatchGroup()
    private var cancellable = Set<AnyCancellable>()
    private var movies: [MovieGroupSections: [Movie]] = [:]
    
    init(service: APIMoviesProtocol) {
        self.service = service
    }
    
    func fetchMovies() {
        MovieGroupSections.allCases.forEach { fetchData(typeMovieSection: $0) }
        group.notify(queue: .main) {
            self.remoteRequestHandler?.fetchedMovies(self.movies)
        }
    }
    
    private func fetchData(typeMovieSection: MovieGroupSections) {
        group.enter()
        service.fetchData(endPoint: typeMovieSection.path, with: defaultParameters)
            .sink( receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                }
            }, receiveValue: { (movies: Movies) in
                self.movies[typeMovieSection] = movies.movies
                self.group.leave()
            }).store(in: &cancellable)
    }
}
