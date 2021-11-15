//
//  Movie.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

struct Movie: Codable {
  
  let id: Int
  let poster: String?
  
  private enum CodingKeys: String, CodingKey {
    case id
    case poster = "poster_path"
  }
}

struct MovieFeedResult: Decodable {
  let results: [Movie]?
}
