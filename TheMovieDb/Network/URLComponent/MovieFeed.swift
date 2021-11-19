//
//  MovieFeed.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

enum MovieFeed: CaseIterable {
  
  case nowPlaying, popular, topRated, trending, upcoming
  
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
  
  var title: String {
    switch self {
    case .trending:
      return "Trending"
    case .nowPlaying:
      return "Now Playing"
    case .popular:
      return "Popular"
    case .topRated:
      return "Top Rated"
    case .upcoming:
      return "Upcoming"
    }
  }
}
