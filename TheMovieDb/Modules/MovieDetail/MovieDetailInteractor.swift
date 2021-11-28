//
//  MovieDetailInteractor.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import Combine

class MovieDetailInteractor: MovieDetailInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: MovieDetailInteractorOutputProtocol?
    private var cancellable: AnyCancellable?
    private var relatedMovies: [MovieDetailSections: [Movie]] = [:]
    private var moviesWorker: MoviesWorkerProtocol!
    private var movie: Movie!
    
    init(movieDetailWorker: MoviesWorkerProtocol, movie: Movie) {
        self.moviesWorker = movieDetailWorker
        self.movie = movie
    }
    
    func getRelatedMovies() {
        let parameters = APIParameters(id: String(movie.id))
        self.cancellable = Publishers.Zip(
            moviesWorker.fetchMovies(endPoint: .recommendations, with: parameters),
            moviesWorker.fetchMovies(endPoint: .similar, with: parameters)
        )
            .sink(receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    self.presenter?.onError(errorMessage: error.localizedDescription)
                }
            }, receiveValue: { (recommendations: Movies, similar: Movies) in
                self.relatedMovies[.recommendations] = recommendations.movies
                self.relatedMovies[.similar] = similar.movies
                self.presenter?.moviesFromInteractor(self.relatedMovies)
            })
    }
    
    func getMovie() {
        presenter?.movieFromInteractor(with: movie)
    }
    
}
