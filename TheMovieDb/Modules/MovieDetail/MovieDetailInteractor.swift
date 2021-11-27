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
    var relatedMovies: [MovieDetailSections: [Movie]] = [:]
    private var movieDetailWorker: MovieDetailWorkerProtocol!
    private var movie: Movie!
    
    init(movieDetailWorker: MovieDetailWorkerProtocol, movie: Movie) {
        self.movieDetailWorker = movieDetailWorker
        self.movie = movie
    }
    
    func getRelatedMovies() {
        let parameters = APIParameters(id: String(movie.id))
        self.cancellable = Publishers.Zip(
            movieDetailWorker.fetchMovies(typeMovieSection: .recommendations, with: parameters),
            movieDetailWorker.fetchMovies(typeMovieSection: .similar, with: parameters)
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
