//
//  Request.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 28/10/21.
//

import Foundation

enum API {
  case getTrendingMovies
  case getNowPlayingMovies
  case getPopularMovies
  case getTopRatedMovies
  case getUpcomingMovies
}

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}
