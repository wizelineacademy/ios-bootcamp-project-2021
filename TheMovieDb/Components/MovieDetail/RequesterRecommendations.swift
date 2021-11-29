//
//  RequesterRecommendations.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 03/11/21.
//

import Foundation

protocol RecommendationProtocol {
  func requestAPIRecommended(id: Int)
  func requestAPISimilar(id: Int)
  func requestAPI(id: Int, completion: @escaping ([Recommendations: [Movie]]) -> Void)
}

final class RecommendationRequester: RecommendationProtocol {
  let group = DispatchGroup()
  
  internal var movies: [Recommendations: [Movie]] = [:]
  
  init() {}
  
  func requestAPIRecommended(id: Int) {
    self.group.enter()
    let completion: (Result<MovieList, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          self?.movies[.recommendedMovies] = response.results
          self?.group.leave()
          
        default:
          self?.movies[.recommendedMovies] = []
          self?.group.leave()
        }
    }
    API.getRecommendedMovies(id: id).resume(completion: completion)
  }
  
  func requestAPISimilar(id: Int) {
    self.group.enter()
    let completion: (Result<MovieList, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          self?.movies[.similarMovies] = response.results
          self?.group.leave()
        default:
          self?.movies[.similarMovies] = []
          self?.group.leave()
        }
    }
    API.getSimilarMovies(id: id).resume(completion: completion)
  }
  
  func requestAPI(id: Int, completion: @escaping ([Recommendations: [Movie]]) -> Void) {
    
    requestAPISimilar(id: id)
    requestAPIRecommended(id: id)
    
    group.notify(queue: .main) {
      completion(self.movies)
    }
  }
}
