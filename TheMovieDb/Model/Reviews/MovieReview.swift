//
//  MovieReview.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

struct MovieReview: Decodable {
  
  var id: String
  var author: String
  var content: String
  var authorDetails: AuthorDetails
  
  private enum CodingKeys: String, CodingKey {
    case id
    case author
    case content
    case authorDetails = "author_details"
  }
}

struct ListReviews: Decodable {
  let results: [MovieReview]?
}
