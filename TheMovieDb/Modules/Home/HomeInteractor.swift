//
//  HomeInteractor.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import Combine

class HomeInteractor: HomeInteractorInputProtocol {
    // MARK: Properties
    weak var presenter: HomeInteractorOutputProtocol?
    private var moviesWorker: MoviesWorkerProtocol!
    private let group = DispatchGroup()
    private var movies: [MovieGroupSections: [Movie]] = [:]
    private var cancellable = Set<AnyCancellable>()
    
    init(movieDetailWorker: MoviesWorkerProtocol) {
        self.moviesWorker = movieDetailWorker
    }

    func getMovies() {
        MovieGroupSections.allCases.forEach { fetchData(typeMovieSection: $0) }
        group.notify(queue: .main) {
            self.presenter?.moviesObtained(self.movies)
        }
    }
    
    private func fetchData(typeMovieSection: MovieGroupSections) {
        group.enter()
        moviesWorker.fetchMovies(endPoint: typeMovieSection.path, with: APIParameters())
            .sink( receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    self.presenter?.onError(errorMessage: error.localizedDescription)
                }
            }, receiveValue: { (movies: Movies) in
                self.movies[typeMovieSection] = movies.movies
                self.group.leave()
            }).store(in: &cancellable)
    }
    
}
