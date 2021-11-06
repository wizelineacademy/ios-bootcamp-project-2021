//
//  SearchRequester.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 05/11/21.
//

import Foundation

protocol SearchProtocol {
  func requestSearch(search: String)
  func requestAPI(search: String, completion: @escaping ([Movie]) -> Void)
}

final class SearchRequester: SearchProtocol {
  let group = DispatchGroup()
  
  internal var movies: [Movie] = []
  
  init() {}
  
  func requestSearch(search: String) {
    self.group.enter()
    let completion: (Result<MovieList, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          self?.movies = response.results
          self?.group.leave()
          
        default:
          self?.movies = []
          self?.group.leave()
        }
    }
    API.searchMovies(search: search).resume(completion: completion)
  }
  
  func requestAPI(search: String, completion: @escaping ([Movie]) -> Void) {
    requestSearch(search: search)
    group.notify(queue: .main) {
      completion(self.movies)
    }
  }
}
