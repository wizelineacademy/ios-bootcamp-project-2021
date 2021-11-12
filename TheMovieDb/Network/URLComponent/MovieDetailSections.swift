//
//  MovieDetailSections.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/12/21.
//

import Foundation

enum MovieDetailSections: CaseIterable {
  case movieDetails, cast, reviews, similarMovies, recommendedMovies
}

extension MovieDetailSections {
  
  var title: String {
    switch self {
    case .movieDetails:
      return "Movie Details"
    case .cast:
      return "Cast"
    case .reviews:
      return "Reviews"
    case .similarMovies:
      return "Similar Movies"
    case .recommendedMovies:
      return "Recommendations"
    }
  }
}
