//
//  InfoById.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

enum InfoById {
  case person(personId: Int)
  case reviews(movieId: Int)
  case credits(movieId: Int)
  case similar(movieId: Int)
  case recommendations(movieId: Int)
  case keywords(movieId: Int)
}

extension InfoById: Endpoint {

  var path: String {
    switch self {
    case .credits(let movieId): return "/3/movie/\(movieId)/credits"
    case .person(let personId): return "/3/person/\(personId)"
    case .recommendations(let movieId): return "/3/movie/\(movieId)/recommendations"
    case .reviews(let movieId): return "/3/movie/\(movieId)/reviews"
    case .similar(let movieId): return "/3/movie/\(movieId)/similar"
    case .keywords(let movieId): return "/3/movie/\(movieId)/keywords"
    }
  }
}
