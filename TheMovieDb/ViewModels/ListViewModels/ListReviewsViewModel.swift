//
//  ListReviewsViewModel.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/22/21.
//

import Foundation
import Combine

class ListReviewsViewModel {
  
  let movieClient: MovieClient
  var cancellables: Set<AnyCancellable> = []
  
  var listReviewsViewModel: [ReviewViewModel] = []
  
  init(movieClient: MovieClient) {
    self.movieClient = movieClient
  }
  
  func getReviews(categories: Endpoint, group: DispatchGroup) {
    group.enter()
    movieClient.fetch(categories, kindItem: ListReviews.self)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { _ in },
            receiveValue: { [weak self] reviews in
        defer { group.leave() }
        guard let reviews = reviews.results else { return }
        self?.listReviewsViewModel = reviews.map { review in
          ReviewViewModel(review: review)
        }
      })
      .store(in: &cancellables)
  }
  
}
