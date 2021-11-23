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
  
  init(movieClient: MovieClient, category: Endpoint? = nil) {
    self.movieClient = movieClient
  }
  
  func getListMovies(categories: Endpoint, title: String, group: DispatchGroup) {
    group.enter()
    movieClient.fetch(categories, kindItem: MovieFeedResult.self)
      .receive(on: RunLoop.main)
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
      .receive(on: RunLoop.main)
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
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { _ in },
            receiveValue: { [weak self] movieDetails in
        defer { group.leave() }
        self?.movieDetails = MovieDetailsViewModel(movieDetails: movieDetails)
      })
      .store(in: &cancellables)
  }
  
}
