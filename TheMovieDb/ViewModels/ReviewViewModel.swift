//
//  ReviewViewModel.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/21/21.
//
import UIKit
import Combine

struct ReviewViewModel {
  
  private let review: MovieReview
  
  init(review: MovieReview) {
    self.review = review
  }
  
  var id: String { review.id }
  
  var author: String { review.author }
  
  var content: String { review.content }
  
  var score: Float? { review.authorDetails.rating }
  
  var profileImageAuthor: String? {
    var url: String?
    guard let portrait = review.authorDetails.avatarPath else { return nil }
    let checkValidUrl = portrait.prefix(9)
    if checkValidUrl == "/https://" {
      var newUrl = portrait
      newUrl.removeFirst()
      url = newUrl
    } else {
      url = ApiPath.baseUrlImage.path + portrait
    }
    return url
  }
  
}
