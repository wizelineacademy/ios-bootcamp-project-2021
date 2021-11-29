//
//  ReviewListViewModel.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 28/11/21.
//

import Foundation

struct ReviewListViewModel {
  private let reviews: [Review]?
}

extension ReviewListViewModel {
  init(_ reviews: [Review]?) {
    self.reviews = reviews
  }
}

extension ReviewListViewModel {
  func numberRows() -> Int {
    return self.reviews?.count ?? 0
  }
  
  func reviewAtIndex(_ index: Int) -> ReviewViewModel? {
    let review = self.reviews?[index]
    return ReviewViewModel(review)
  }
}
