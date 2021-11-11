//
//  MovieDetails.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/3/21.
//

import Foundation

struct MovieDetails: Codable {
  
  let id: Int
  let title: String
  let poster: String
  let overview: String
  let releaseDate: String
  let voteAverage: Float
  let popularity: Float
  let budget: Int
  let backDropPath: String?
  let genres: [Genres]
  let revenue: Int
  let originalLanguage: String
  let status: String
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case poster = "poster_path"
    case releaseDate = "release_date"
    case overview
    case voteAverage = "vote_average"
    case popularity
    case budget
    case backDropPath = "backdrop_path"
    case genres
    case revenue
    case originalLanguage = "original_language"
    case status
    
  }
}

extension MovieDetails {
  
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
  
  func numberFormat(dollars: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 0
    formatter.usesGroupingSeparator = true
    if let result = formatter.string(from: NSNumber(value: dollars)) {
      return result
    }
    return "0"
  }
  
}

struct Genres: Codable {
  let name: String
}
