//
//  MovieInfoViewModel.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 12/11/21.
//

import Foundation
import os.log
import Combine

final class MovieInfoViewModel {
    var movieID: Int?
    var showError: ((MovieError) -> Void)?
    var loadMovieInfo: (() -> Void)?
    var movie: Movie? {
        didSet {
            DispatchQueue.main.async {
                self.loadMovieInfo?()
            }
        }
    }
    
    var loadSimilarMovies: (() -> Void)?
    var similarMoviesNames: String? {
        didSet {
            DispatchQueue.main.async {
                self.loadSimilarMovies?()
            }
        }
    }
    
    var loadRecommendedMovies: (() -> Void)?
    var recommendedMoviesNames: String? {
        didSet {
            DispatchQueue.main.async {
                self.loadRecommendedMovies?()
            }
        }
    }
    
    var loadCastMovie: (() -> Void)?
    var castMovie: String? {
        didSet {
            DispatchQueue.main.async {
                self.loadCastMovie?()
            }
        }
    }
    
    private var facade: MovieService
    var subscriptions = Set<AnyCancellable>()
    
    init(facade: MovieService) {
        self.facade = facade
        os_log("MovieInfoViewModel initialized", log: OSLog.viewModel, type: .debug)
    }
    
    func getMovieDetail() {
        guard let id = movieID else { return }
        facade.get(type: Movie.self, search: nil, endpoint: .movieDetails(id: id))
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case let .failure(error):
                    self.showError?(error)
                    os_log("MovieInfoViewModel getMovieDetail failure", log: OSLog.viewModel, type: .error)
                case .finished: break
                }
            }, receiveValue: { movie in
                self.movie = movie
            })
            .store(in: &subscriptions)
    }
    
    func similarMovies() {
        guard let id = movieID else { return }
        facade.get(type: MovieResponse<Movie>.self, search: nil, endpoint: .similar(id: id))
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case let .failure(error):
                    self.showError?(error)
                    os_log("MovieInfoViewModel similarMovies failure", log: OSLog.viewModel, type: .error)
                case .finished: break
                }
            }, receiveValue: { movieResponse in
                let movies = movieResponse.results
                let movieNames = movies?.compactMap({ $0.title }).prefix(3)
                self.similarMoviesNames = movieNames?.joined(separator: ", ")
            })
            .store(in: &subscriptions)
    }
    
    func recomendedMovies() {
        guard let id = movieID else { return }
        facade.get(type: MovieResponse<Movie>.self, search: nil, endpoint: .recommendations(id: id))
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case let .failure(error):
                    self.showError?(error)
                    os_log("MovieInfoViewModel recomendedMovies failure", log: OSLog.viewModel, type: .error)
                case .finished: break
                }
            }, receiveValue: { movieResponse in
                guard movieResponse.results?.count ?? 0 > 0 else { return }
                let movies = movieResponse.results
                let movieNames = movies?.compactMap({ $0.title }).prefix(3)
                self.recommendedMoviesNames = movieNames?.joined(separator: ", ")
            })
            .store(in: &subscriptions)
    }
    
    func castFromMovie() {
        guard let id = movieID else { return }
        facade.get(type: CreditsMovie.self, search: nil, endpoint: .credits(id: id))
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case let .failure(error):
                    self.showError?(error)
                    os_log("MovieInfoViewModel castFromMovie failure", log: OSLog.viewModel, type: .error)
                case .finished: break
                }
            }, receiveValue: { creditsResponse in
                let castMovie = creditsResponse.cast
                let castNames = castMovie?.compactMap({ $0.name }).prefix(3)
                self.castMovie = castNames?.joined(separator: ", ")
            })
            .store(in: &subscriptions)
    }
    
    func fetchServices() {
        getMovieDetail()
        similarMovies()
        recomendedMovies()
        castFromMovie()
    }
}
