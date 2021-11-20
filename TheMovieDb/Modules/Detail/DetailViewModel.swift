//
//  DetailViewModel.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 06/11/21.
//

import Foundation

protocol ViewModel {
    associatedtype Dependencies
}

typealias DetailMovieRepository = RelatedMoviesRepository & MovieCastRepository

protocol DetailViewModelDelegate: AnyObject {
    func didStartLoading()
    func didFinishLoading()
    func didUpdateRelatedMovieData()
}

class DetailViewModel: ViewModel {
    
    weak var delegate: DetailViewModelDelegate?
    
    struct Dependencies {
        let movie: Movie
        let service: DetailMovieRepository
        
        init(movie: Movie, service: DetailMovieRepository = MovieDBAPI()) {
            self.movie = movie
            self.service = service
        }
    }
    
    private let dependencies: Dependencies
    
    private var similarMovies: [Movie]?
    
    private var recommendations: [Movie]?
    
    private var cast: [CastMember]?
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func getMovie() -> Movie {
        dependencies.movie
    }
    
    func getMovieTitle() -> String {
        dependencies.movie.title
    }
    
    func getMovieOverview() -> String {
        dependencies.movie.overview
    }
    
    func getMovieReleaseDate() -> String {
        dependencies.movie.releaseDate
    }
    
    func getMoviePosterPath() -> String? {
        dependencies.movie.posterPath
    }
    
    func getSimilarMovies() -> String? {
        guard let similarMovies = similarMovies else {
            return nil
        }
        return similarMovies.prefix(5)
            .map { $0.title }
            .joined(separator: ", ")
    }
    
    func getRecommendationMovies() -> String? {
        guard let recommendations = recommendations else {
            return nil
        }
        return recommendations.prefix(5)
            .map { $0.title }
            .joined(separator: ", ")
    }
    
    func getCast() -> String? {
        guard let cast = cast else {
            return nil
        }
        return cast.prefix(5)
            .map { "\($0.name): \($0.character)" }
            .joined(separator: "\n")
    }
    
    func requestRelatedMovieData() {
        delegate?.didStartLoading()
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        dependencies.service.getRelatedMovies(
            for: dependencies.movie,
            on: .similar
        ) { [weak self] result in
            switch result {
            case .success(let data):
                self?.similarMovies = data.results
            case .failure(let error):
                print(error)
            }
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        dependencies.service.getRelatedMovies(
            for: dependencies.movie,
            on: .recommendation
        ) { [weak self] result in
            switch result {
            case .success(let data):
                self?.recommendations = data.results
            case .failure(let error):
                print(error)
            }
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        dependencies.service.getMovieCast(
            for: dependencies.movie
        ) { [weak self] result in
            switch result {
            case .success(let data):
                self?.cast = data.cast
            case .failure(let error):
                print(error)
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            self.delegate?.didFinishLoading()
            self.delegate?.didUpdateRelatedMovieData()
        }
    }
    
}
