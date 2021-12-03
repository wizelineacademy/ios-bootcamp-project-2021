//
//  AuthorDetails.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

struct AuthorDetails: Decodable {

  var avatarPath: String?
  var rating: Float?
  
  private enum CodingKeys: String, CodingKey {
    case avatarPath = "avatar_path"
    case rating
  }
}
