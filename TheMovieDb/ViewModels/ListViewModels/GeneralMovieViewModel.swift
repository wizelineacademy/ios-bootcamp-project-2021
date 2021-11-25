//
//  ListMovieViewModel.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/22/21.
//
import Foundation
import Combine

class GeneralMovieViewModel {
  
  let movieClient: MovieClient
  var cancellables: Set<AnyCancellable> = []
  
  var listMovieViewModel: [String: [MovieViewModel]] = [:]
  var listSimilarOrRecommendedViewModel: [MovieViewModel] = []
  var movieDetails: MovieDetailsViewModel?
  var searchMovie: [MovieViewModel] = []
  
  init(movieClient: MovieClient, category: Endpoint? = nil) {
    self.movieClient = movieClient
  }
  
  func getListMovies(categories: Endpoint, title: String, group: DispatchGroup) {
    group.enter()
    movieClient.fetch(categories, kindItem: MovieFeedResult.self)
      .sink(receiveCompletion: { _ in },
            receiveValue: { [weak self] movies in
        defer { group.leave() }
        guard let listMovies = movies.results else { return }
        self?.listMovieViewModel[title] = listMovies.map { movie in
          MovieViewModel(movie: movie)
        }
      })
      .store(in: &cancellables)
  }
  
  func getSimilarOrRecommendedMovies(categories: Endpoint, group: DispatchGroup) {
    group.enter()
    movieClient.fetch(categories, kindItem: MovieFeedResult.self)
      .sink(receiveCompletion: { _ in },
            receiveValue: { [weak self] movies in
        defer { group.leave() }
        guard let listMovies = movies.results else { return }
        self?.listSimilarOrRecommendedViewModel = listMovies.map { movie in
          MovieViewModel(movie: movie)
        }
      })
      .store(in: &cancellables)
  }
  
  func getMovieDetails(categories: Endpoint, group: DispatchGroup) {
    group.enter()
    movieClient.fetch(categories, kindItem: MovieDetails.self)
      .sink(receiveCompletion: { _ in },
            receiveValue: { [weak self] movieDetails in
        defer { group.leave() }
        self?.movieDetails = MovieDetailsViewModel(movieDetails: movieDetails)
      })
      .store(in: &cancellables)
  }
  
  func searchMovies(endPoint: Endpoint, search: String, group: DispatchGroup) {
    group.enter()
    movieClient.fetch(endPoint, kindItem: MovieFeedResult.self, search: search)
      .sink(receiveCompletion: { _ in },
            receiveValue: { [weak self] movies in
        defer { group.leave() }
        guard let listMovies = movies.results else { return }
        self?.searchMovie = listMovies.map { movie in
          return MovieViewModel(movie: movie)
        }
      })
      .store(in: &cancellables)
  }
  
}
