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
  let popularity: Float
  let knownFor: String
  let placeOfBirth: String?
  
  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case profilePath = "profile_path"
    case character
    case popularity
    case knownFor = "known_for_department"
    case placeOfBirth = "place_of_birth"
  }
}

struct Credits: Decodable {
  let cast: [Person]?
}
