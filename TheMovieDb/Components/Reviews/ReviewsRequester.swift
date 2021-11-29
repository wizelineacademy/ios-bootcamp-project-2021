//
//  ReviewsRequester.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 05/11/21.
//

import Foundation

protocol ReviewsProtocol {
  func requestAPIReviews()
  func requestAPI(completion: @escaping ([Review]) -> Void)
}

final class ReviewsRequester: ReviewsProtocol {
  let group = DispatchGroup()
  let id: Int?
  internal var reviews: [Review] = []
  
  init(id: Int) {
    self.id = id
  }
  
  func requestAPIReviews() {
    self.group.enter()
    let completion: (Result<ReviewsList, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          self?.reviews = response.results
          self?.group.leave()
          
        default:
          self?.reviews = []
          self?.group.leave()
        }
    }
    API.getReviews(id: id ?? 0).resume(completion: completion)
  }
  
  func requestAPI(completion: @escaping ([Review]) -> Void) {
    requestAPIReviews()
    group.notify(queue: .main) {
      completion(self.reviews)
    }
  }
}
