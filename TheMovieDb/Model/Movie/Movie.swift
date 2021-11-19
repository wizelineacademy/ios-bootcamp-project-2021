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
  let poster: String
  let releaseDate: String
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case poster = "poster_path"
    case releaseDate = "release_date"
  }
}

extension Movie {
  func getDate() -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.date(from: releaseDate )
  }
  
  func getMovieReleaseDateFormat() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, yyyy"
    guard let movieReleaseDate = getDate() else { return ""}
    return formatter.string(from: movieReleaseDate)
  }
}

struct MovieFeedResult: Decodable {
  let results: [Movie]?
}
