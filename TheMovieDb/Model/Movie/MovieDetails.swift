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
  let imdbId: String?
  let tagline: String?
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
    case imdbId = "imdb_id"
    case tagline
    case status
    
  }
}

struct Genres: Codable {
  let name: String
}
