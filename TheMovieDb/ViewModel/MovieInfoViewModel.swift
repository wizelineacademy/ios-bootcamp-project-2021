//
//  MovieInfoViewModel.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 12/11/21.
//

import Foundation
import os.log

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
    
    init(facade: MovieService) {
        self.facade = facade
        os_log("MovieInfoViewModel initialized", log: OSLog.viewModel, type: .debug)
    }
    
    func getMovieDetail() {
        guard let id = movieID else { return }
        facade.get(search: nil, endpoint: .movieDetails(id: id)) { [weak self] (response: Result<Movie, MovieError>) in
            guard let self = self else { return }
            switch response {
            case.success(let movie):
                self.movie = movie
            case .failure(let failureResult):
                self.showError?(failureResult)
                os_log("MovieInfoViewModel getMovieDetail failure", log: OSLog.viewModel, type: .error)
            }
        }
    }
    
    func similarMovies() {
        guard let id = movieID else { return }
        facade.get(search: nil, endpoint: .similar(id: id)) { [weak self] (response: Result<MovieResponse<Movie>, MovieError>) in
            guard let self = self else { return }
            switch response {
            case.success(let movieResponse):
                let movies = movieResponse.results
                let movieNames = movies?.compactMap({ $0.title }).prefix(3)
                self.similarMoviesNames = movieNames?.joined(separator: ", ")
            case .failure(let failureResult):
                self.showError?(failureResult)
                os_log("MovieInfoViewModel similarMovies failure", log: OSLog.viewModel, type: .error)
            }
        }
    }
    
    func recomendedMovies() {
        guard let id = movieID else { return }
        facade.get(search: nil, endpoint: .recommendations(id: id)) { [weak self] (response: Result<MovieResponse<Movie>, MovieError>) in
            guard let self = self else { return }
            switch response {
            case.success(let movieResponse):
                guard movieResponse.results?.count ?? 0 > 0 else { return }
                let movies = movieResponse.results
                let movieNames = movies?.compactMap({ $0.title }).prefix(3)
                self.recommendedMoviesNames = movieNames?.joined(separator: ", ")
            case .failure(let failureResult):
                self.showError?(failureResult)
                os_log("MovieInfoViewModel recomendedMovies failure", log: OSLog.viewModel, type: .error)
            }
        }
    }
    
    func castFromMovie() {
        guard let id = movieID else { return }
        facade.get(search: nil, endpoint: .credits(id: id)) { [weak self] (response: Result<CreditsMovie, MovieError>) in
            guard let self = self else { return }
            switch response {
            case.success(let creditsResponse):
                let castMovie = creditsResponse.cast
                let castNames = castMovie?.compactMap({ $0.name }).prefix(3)
                self.castMovie = castNames?.joined(separator: ", ")
            case .failure(let failureResult):
                self.showError?(failureResult)
                os_log("MovieInfoViewModel castFromMovie failure", log: OSLog.viewModel, type: .error)
            }
        }
    }
    
    func fetchServices() {
        getMovieDetail()
        similarMovies()
        recomendedMovies()
        castFromMovie()
    }
}
