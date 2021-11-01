//
//  AuthorDetails.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

struct AuthorDetails: Codable {
  
  var name: String?
  var username: String
  var avatarPath: String?
  var rating: Int?
  
  private enum CodingKeys : String, CodingKey{
    case name
    case username
    case avatarPath = "avatar_path"
    case rating
  }
}
