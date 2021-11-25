//
//  MoviesHomeInteractor.swift
//  TheMovieDb
//
//  Created by developer on 17/11/21.
//

import Foundation

final class MoviesHomeInteractor: MoviesHomeInteractorInputProtocol {
    var apiDataManager: MoviesHomeAPIDataManagerProtocol?
    weak var presenter: MoviesHomeInteractorOutputProtocol?
    var moviesFeed: MoviesFeed = MoviesFeed(listsOfElements: [:])
   
    func fetchMovies() {
        let group = DispatchGroup()
        for topic in Topic.allCases {
            let request = Request(path: topic.getPath(), method: .get, group: group)
            apiDataManager?.requestMovies(value: MovieList.self, request: request, completion: { [weak self] result in
                switch result {
                case .success(let movieList):
                    if let list = movieList {
                        self?.moviesFeed.addList(topic: topic, movieList: list)
                    }
                    
                case .failure(let error):
                    self?.presenter?.fetchMoviesDidFail(with: error)
                }
            })
        }
        
        group.notify(queue: .main) {
            self.presenter?.moviesDidFetch(movies: self.moviesFeed)
        }
    }
}
