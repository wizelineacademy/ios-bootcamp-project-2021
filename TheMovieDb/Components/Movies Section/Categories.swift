//
//  Categories.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 31/10/21.
//

import Foundation

enum CategoriesText: String, CaseIterable {
  case trendingMoviesText = "Trending Movies"
  case nowPlayingMoviesText = "Now Playing Movies"
  case popularMoviesText = "Popular Movies"
  case topRatedMoviesText = "Top Rated Movies"
  case upcomingMoviesText = "Upcoming Movies"
}

enum Categories: CaseIterable {
  case trendingMovies
  case nowPlayingMovies
  case popularMovies
  case topRatedMovies
  case upcomingMovies
}
