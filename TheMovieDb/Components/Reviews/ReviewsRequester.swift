//
//  ReviewsRequester.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 05/11/21.
//

import Foundation

protocol ReviewsProtocol {
  func requestAPIReviews(id: Int)
  func requestAPI(id: Int, completion: @escaping ([Review]) -> Void)
}

final class ReviewsRequester: ReviewsProtocol {
  let group = DispatchGroup()
  
  internal var reviews: [Review] = []
  
  init() {}
  
  func requestAPIReviews(id: Int) {
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
    API.getReviews(id: id).resume(completion: completion)
  }
  
  func requestAPI(id: Int, completion: @escaping ([Review]) -> Void) {
    requestAPIReviews(id: id)
    group.notify(queue: .main) {
      completion(self.reviews)
    }
  }
}
