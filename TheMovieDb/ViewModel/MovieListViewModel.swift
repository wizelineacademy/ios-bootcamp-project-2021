//
//  MovieListViewModel.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 12/11/21.
//

import Foundation
import os.log

final class MovieListViewModel {
    var movieListOption: MoviesOptions = .nowPlaying
    var reloadData: (() -> Void)?
    var showError: ((MovieError) -> Void)?
    var facade: MovieService
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    init(facade: MovieService) {
        self.facade = facade
        os_log("MovieListViewModel initialized", log: OSLog.viewModel, type: .debug)
    }
    
    func loadMovies() {
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
                    self.showError?(.invalidResponse)
                    os_log("MovieListViewModel results error", log: OSLog.viewModel, type: .error)
                    return
                }
                self.movies = results
                
            case .failure(let failureResult):
                self.showError?(failureResult)
                os_log("MovieListViewModel failure", log: OSLog.viewModel, type: .error)
            }
        }
    }
    
}
