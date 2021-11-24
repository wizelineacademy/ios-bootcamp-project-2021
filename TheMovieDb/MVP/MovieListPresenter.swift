//
//  MovieListPresenter.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 23/11/21.
//

import Foundation
import os.log

protocol MovieListView: AnyObject {
    func onUpdateMovies()
    func showError(_ error: MovieError)
    func didSetTitle(title: String)
}

final class MovieListPresenter {
    weak private var viewMovieList: MovieListView?
    private let facade: MovieService
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
        facade.get(search: nil, endpoint: endpoint) { [weak self] (response: Result<MovieResponse<Movie>, MovieError>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let sucessResult):
                guard let results = sucessResult.results else {
                    self.viewMovieList?.showError(.invalidResponse)
                    os_log("MovieListPresenter results error", log: OSLog.viewModel, type: .error)
                    return
                }
                self.updateMovies(response: results)
                
            case .failure(let failureResult):
                self.viewMovieList?.showError(failureResult)
                os_log("MovieListPresenter failure", log: OSLog.viewModel, type: .error)
            }
        }
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
