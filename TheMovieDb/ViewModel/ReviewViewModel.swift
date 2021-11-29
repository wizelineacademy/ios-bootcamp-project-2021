//
//  ReviewViewModel.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 28/11/21.
//

import Foundation

struct ReviewViewModel {
  private let review: Review?
}

extension ReviewViewModel {
  init(_ review: Review?) {
    self.review = review
  }
}

extension ReviewViewModel {
  var content: String {
    return self.review?.content ?? ""
  }
  
  var author: String {
    return self.review?.author ?? ""
  }
  
  var rating: Float {
    return self.review?.rating ?? 0
  }
}
