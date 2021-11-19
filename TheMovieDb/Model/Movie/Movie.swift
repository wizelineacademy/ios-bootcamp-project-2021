//
//  Movie.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

struct Movie: Codable {
  
  let id: Int
  let title: String
  let poster: String?
  let releaseDate: String
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case poster = "poster_path"
    case releaseDate = "release_date"
  }
}

struct MovieFeedResult: Decodable {
  let results: [Movie]?
}
