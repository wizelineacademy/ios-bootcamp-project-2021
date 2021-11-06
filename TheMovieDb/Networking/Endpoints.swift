//
//  Endpoints.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 03/11/21.
//

import Foundation

enum API {
  case getTrendingMovies
  case getNowPlayingMovies
  case getPopularMovies
  case getTopRatedMovies
  case getUpcomingMovies
  case getRecommendedMovies(id: Int)
  case getSimilarMovies(id: Int)
  case getReviews(id: Int)
  case searchMovies(search: String)
}
