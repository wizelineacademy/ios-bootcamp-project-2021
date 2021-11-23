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
  let overview: String
  let releaseDate: String
  let voteAverage: Float
  let budget: Int
  let backDropPath: String?
  let revenue: Int
  let originalLanguage: String
  let status: String
  var cast: [Person]?
  var reviews: [MovieReview]?
  var similarMovies: [Movie]?
  var recommendedMovies: [Movie]?
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case releaseDate = "release_date"
    case overview
    case voteAverage = "vote_average"
    case budget
    case backDropPath = "backdrop_path"
    case revenue
    case originalLanguage = "original_language"
    case status
    case cast
    case reviews
    case similarMovies
    case recommendedMovies
    
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
  
  func getNumberFormat(dollars: Int) -> String {
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
