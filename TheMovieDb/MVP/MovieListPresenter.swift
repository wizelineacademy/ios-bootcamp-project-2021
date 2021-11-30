//
//  MovieListPresenter.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 23/11/21.
//

import Foundation
import os.log
import Combine

protocol MovieListView: AnyObject {
    func onUpdateMovies()
    func showError(_ error: MovieError)
    func didSetTitle(title: String)
    func didSelectMovie(with id: Int)
}

final class MovieListPresenter {
    weak private var viewMovieList: MovieListView?
    private let facade: MovieService
    private var subscriptions = Set<AnyCancellable>()
    var movies: [Movie] = []
    var movieListOption: MoviesOptions {
        didSet {
            self.listMovies()
            self.setTitle()
        }
    }
    
    init(view: MovieListView, facade: MovieService, movieOption: MoviesOptions) {
        self.viewMovieList = view
        self.facade = facade
        self.movieListOption = movieOption
        self.setTitle()
    }
    
    func listMovies() {
        let endpoint: MovieListEndpoint
        switch movieListOption {
        case .trending:
            endpoint = .trending
        case .nowPlaying:
            endpoint = .nowPlaying
        case .popular:
            endpoint = .popular
        case .topRated:
            endpoint = .topRated
        case .upcoming:
            endpoint = .upcoming
        }
        
        facade.get(type: MovieResponse<Movie>.self, search: nil, endpoint: endpoint)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case let .failure(error):
                    self.viewMovieList?.showError(error)
                    os_log("MovieListPresenter failure", log: OSLog.viewModel, type: .error)
                case .finished: break
                }
            }, receiveValue: { sucessResult in
                guard let results = sucessResult.results else {
                    self.viewMovieList?.showError(.invalidResponse)
                    os_log("MovieListPresenter results error", log: OSLog.viewModel, type: .error)
                    return
                }
                self.updateMovies(response: results)
            })
            .store(in: &subscriptions)
    }
    
    func didSelectMovie(at position: Int) {
        let movie = movies[position]
        
        guard let movieId = movie.id else {
            return
        }
        
        self.viewMovieList?.didSelectMovie(with: movieId)
    }
}

private extension MovieListPresenter {
    func setTitle() {
        self.viewMovieList?.didSetTitle(title: movieListOption.title)
    }
    
    func updateMovies(response: [Movie]) {
        movies = response
        self.viewMovieList?.onUpdateMovies()
    }
}
