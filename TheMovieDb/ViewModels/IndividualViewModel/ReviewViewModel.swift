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
  
  var profileImageAuthor: String? {
    var url: String?
    var portrait = review.authorDetails.avatarPath
    let checkValidUrl = portrait?.prefix(9)
    if checkValidUrl == "/https://" {
      portrait?.removeFirst()
      url = portrait
    } else {
      if portrait != nil {
        url = "\(ApiPath.baseUrlImage.path)\(portrait ?? "")"
      }
    }
    return url
  }
  
}
