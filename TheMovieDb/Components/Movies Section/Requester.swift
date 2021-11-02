//
//  MovieRequest.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 01/11/21.
//

import Foundation

protocol MovieRequest {
  func requestAPITrending()
  func requestAPINowPlaying()
  func requestAPIPopular()
  func requestAPITopRated()
  func requestAPIUpcoming()
  func requestAPI(completion: @escaping ([Categories: [Movie]]) -> Void)
  var movies: [Categories: [Movie]] { get }
  
}

final class Requester: MovieRequest {
  
  let group = DispatchGroup()
  
  internal var movies: [Categories: [Movie]] = [:]
  
  init() {}
  
  func requestAPITrending() {
    self.group.enter()
    let completion: (Result<MovieList, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          self?.movies[.trendingMovies] = response.results
          print(response)
          self?.group.leave()
          
        default:
          self?.movies[.trendingMovies] = []
          self?.group.leave()
        }
    }
    API.getTrendingMovies.resume(completion: completion)
  }
  
  func requestAPINowPlaying() {
    self.group.enter()
    let completion: (Result<MovieList, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          self?.movies[.nowPlayingMovies] = response.results
          print(response)
          self?.group.leave()
          
        default:
          self?.movies[.nowPlayingMovies] = []
          self?.group.leave()
        }
    }
    API.getNowPlayingMovies.resume(completion: completion)
  }
  
  func requestAPIPopular() {
    self.group.enter()
    let completion: (Result<MovieList, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          self?.movies[.popularMovies] = response.results
          print(response)
          self?.group.leave()
          
        default:
          self?.movies[.popularMovies] = []
          self?.group.leave()
        }
    }
    API.getPopularMovies.resume(completion: completion)
  }
  
  func requestAPITopRated() {
    self.group.enter()
    let completion: (Result<MovieList, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          self?.movies[.topRatedMovies] = response.results
          print(response)
          self?.group.leave()
          
        default:
          self?.movies[.topRatedMovies] = []
          self?.group.leave()
        }
    }
    API.getTopRatedMovies.resume(completion: completion)
  }
  
  func requestAPIUpcoming() {
    self.group.enter()
    let completion: (Result<MovieList, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          self?.movies[.upcomingMovies] = response.results
          print(response)
          self?.group.leave()
          
        default:
          self?.movies[.upcomingMovies] = []
          self?.group.leave()
        }
    }
    API.getUpcomingMovies.resume(completion: completion)
  }
  
  func requestAPI(completion: @escaping ([Categories: [Movie]]) -> Void) {
    requestAPIPopular()
    requestAPIUpcoming()
    requestAPITrending()
    requestAPITopRated()
    requestAPINowPlaying()
    group.notify(queue: .main) {
      print("Notify")
      completion(self.movies)
    }
  }
}
