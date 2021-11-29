//
//  MoviesList.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 28/10/21.
//

import Foundation

struct Movie: Decodable {
  
  let posterPath: String? // Get images with https://image.tmdb.org/t/p/w500
  let voteAverage: Float
  let releaseDate: Date?
  let title: String
  let originalLanguage: String
  let genreIds: [Int]
  let overview: String
  let voteCount: Int
  let id: Int
  
  enum CodingKeys: CodingKey {
    case poster_path
    case vote_average
    case release_date
    case title
    case original_language
    case genre_ids
    case overview
    case vote_count
    case id
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    do {
       self.posterPath = try "https://image.tmdb.org/t/p/w500" + container.decode(String.self, forKey: .poster_path)
    } catch {
      self.posterPath = ""
    }
    
    self.voteAverage = try container.decode(Float.self, forKey: .vote_average)
    
    let releaseDateConverted = try container.decode(String.self, forKey: .release_date)
    do {
      self.releaseDate = releaseDateConverted.changeToDate()
    } 
    
    self.title = try container.decode(String.self, forKey: .title)
    self.originalLanguage = try container.decode(String.self, forKey: .original_language)
    self.genreIds = try container.decode([Int].self, forKey: .genre_ids)
    self.overview = try container.decode(String.self, forKey: .overview)
    self.voteCount = try container.decode(Int.self, forKey: .vote_count)
    self.id = try container.decode(Int.self, forKey: .id)
  }
  
}

struct MovieList: Decodable {
  let results: [Movie]
  let page: Int
  
  enum CodingKeys: String, CodingKey {
    case results
    case page
  }
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.results = try container.decode([Movie].self, forKey: .results)
    self.page = try container.decode(Int.self, forKey: .page)
  }
}
