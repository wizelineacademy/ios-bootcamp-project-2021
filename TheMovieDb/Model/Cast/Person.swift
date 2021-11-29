//
//  Person.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

struct Person: Codable {
  
  let id: Int
  let name: String
  let profilePath: String?
  let character: String

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case profilePath = "profile_path"
    case character
  }
}

struct Credits: Decodable {
  let cast: [Person]?
}
