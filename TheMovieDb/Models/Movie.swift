//
//  Movie.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 27/10/21.
//

import Foundation

struct MoviesResponse: Encodable, Decodable {
  let page: Int
  let results: [Movie]
  let total_pages: Int
  let total_results: Int
}

struct Movie: Encodable, Decodable {
  let original_title: String
  let poster_path: String // Get images with https://image.tmdb.org/t/p/w500
  let vote_average: Double
  let overview: String
  let release_date: String
  let vote_count: Int
  let title: String
  let original_language: String
  let genre_ids: [Int]
}
