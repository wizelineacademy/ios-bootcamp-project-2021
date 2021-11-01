//
//  MovieReview.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

struct MovieReview : Codable {
  
  var id: String
  var author : String
  var content : String
  var authorDetails: AuthorDetails
  var createdAt: String
  
  private enum CodingKeys : String, CodingKey{
    case id
    case author
    case content
    case authorDetails = "author_details"
    case createdAt = "created_at"
  }
}
