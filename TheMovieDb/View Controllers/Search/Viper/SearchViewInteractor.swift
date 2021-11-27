//
//  SearchViewInteractor.swift
//  TheMovieDb
//
//  Created by developer on 26/11/21.
//

import Foundation

class SearchViewInteractor: SearchViewInteractorInputProtocol {
  
    var apiDataManager: SearchViewAPIDataManagerProtocol?
    var presenter: SearchViewInteractorOutputProtocol?
    
    func fetchInitialMovies(topic: Topic) {
        let topic = Topic.topRated
            let request = Request(path: topic.getPath(), method: .get, group: nil)
            apiDataManager?.requestMovies(value: MovieList.self, request: request, completion: { [weak self] result in
                switch result {
                case .success(let movieList):
                    if let list = movieList {
                        self?.presenter?.didFetchMovies(movieList: list)
                    }
                case .failure(let error):
                    self?.presenter?.fetchMoviesDidFail(error: error)
                }
            })
    }
    
    func fetchSearchedMovies(text: String) {
        print(Endpoints.search(text: text))
        let group = DispatchGroup()
        let request = Request(path: Endpoints.search(text: text), method: .get, group: group)
        var searchedMovieList = MovieList(results: [])
        apiDataManager?.requestMovies(value: MovieList.self, request: request, completion: { [weak self] result in
            switch result {
            case .success(let movieList):
                if let list = movieList {
                    searchedMovieList = list
                }
            case .failure(let error):
                self?.presenter?.fetchMoviesDidFail(error: error)
            }
        })
        
        group.notify(queue: .main) {
            self.presenter?.didFetchSearchedMovies(movieList: searchedMovieList)
        }
    }
}
