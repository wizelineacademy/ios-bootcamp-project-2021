//
//  SearchRequester.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 05/11/21.
//

import Foundation

protocol SearchProtocol {
  func requestSearch()
  func requestAPI(completion: @escaping ([Movie]) -> Void)
}

final class SearchRequester: SearchProtocol {
  let group = DispatchGroup()
  
  internal var movies: [Movie] = []
  let searchText: String?
  init(searchText: String?) {
    self.searchText = searchText
  }
  
  func requestSearch() {
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
    API.searchMovies(search: searchText ?? "").resume(completion: completion)
  }
  
  func requestAPI(completion: @escaping ([Movie]) -> Void) {
    requestSearch()
    group.notify(queue: .main) {
      completion(self.movies)
    }
  }
}
