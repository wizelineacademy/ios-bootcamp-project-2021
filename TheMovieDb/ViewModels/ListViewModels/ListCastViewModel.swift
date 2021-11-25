//
//  ListCastViewModel.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/22/21.
//

import Foundation
import Combine

class ListCastViewModel {
  
  let movieClient: MovieClient
  var cancellables: Set<AnyCancellable> = []
  
  var listCastViewModel: [PersonViewModel] = []
  
  init(movieClient: MovieClient) {
    self.movieClient = movieClient
  }
  
  func getCast(categories: Endpoint, group: DispatchGroup) {
    group.enter()
    movieClient.fetch(categories, kindItem: Credits.self)
      .sink(receiveCompletion: { _ in },
            receiveValue: { [weak self] cast in
        defer { group.leave() }
        guard let cast = cast.cast else { return }
        self?.listCastViewModel = cast.map { person in
          PersonViewModel(person: person)
        }
      })
      .store(in: &cancellables)
  }
  
}
