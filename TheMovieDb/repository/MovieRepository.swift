//
//  ListMovieViewModel.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/22/21.
//
import Foundation
import Combine

class MovieRepository {
  
  let movieClient: MovieClient
  var cancellables: Set<AnyCancellable> = []
  
  init(movieClient: MovieClient, category: Endpoint? = nil) {
    self.movieClient = movieClient
  }
  
  func getDataMovies<Element: Decodable>(
    categories: Endpoint,
    search: String? = nil,
    group: DispatchGroup,
    kindOfElement: Element.Type,
    complete: @escaping (Element) -> Void) {
      group.enter()
      movieClient.fetch(categories, kindItem: Element.self, search: search)
        .sink(receiveCompletion: { _ in },
              receiveValue: { item in
          defer { group.leave() }
          complete(item)
        })
        .store(in: &cancellables)
  }
  
}
