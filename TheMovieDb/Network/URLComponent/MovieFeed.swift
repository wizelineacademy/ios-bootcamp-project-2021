//
//  MovieFeed.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

enum MovieFeed {
  
  case trending
  case nowPlaying
  case popular
  case topRated
  case upcoming
  
}

extension MovieFeed: Endpoint {
  
  var path: String {
    switch self {
    case .nowPlaying: return "/3/movie/now_playing"
    case .topRated: return "/3/movie/top_rated"
    case .trending: return "/3/trending/movie/day"
    case .popular: return "/3/movie/popular"
    case .upcoming: return "/3/movie/upcoming"
      
    }
  }
}
