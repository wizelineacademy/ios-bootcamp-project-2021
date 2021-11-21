//
//  MoviesHomeInteractor.swift
//  TheMovieDb
//
//  Created by developer on 17/11/21.
//

import Foundation

final class MoviesHomeInteractor: MoviesHomeInteractorInputProtocol {
    weak var presenter: MoviesHomeInteractorOutputProtocol?
    var moviesFeed: MoviesFeed = MoviesFeed(listsOfElements: [:])
   
    func fetchMovies() {
        
        
        let group = DispatchGroup()
        
        for topic in Topic.allCases {
            let request = Request(path: topic.getPath(), method: .get, group: group)
            
            MovieDbAPI.request(value: MovieList.self, request: request) { [weak self] result in
                
                switch result {
                case .success(let result):
                guard let listOfMovies = result else { return }
                    self?.moviesFeed.addList(topic: topic, movieList: listOfMovies)

                case .failure(let error):
                    print(error)
                }
            }
        }
        
        group.notify(queue: .main) {
            self.presenter?.moviesDidFetch(movies: self.moviesFeed)
        }
        
        
    }
}
