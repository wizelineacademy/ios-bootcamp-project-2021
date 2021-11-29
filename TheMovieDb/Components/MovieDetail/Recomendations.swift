//
//  Recomendations.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 02/11/21.
//

import Foundation

enum RecommendationsText: String, CaseIterable {
  case similarMoviesText = "Similar Movies"
  case recommendedMoviesText = "Recommended Movies"
  
}

enum Recommendations: CaseIterable {
  case similarMovies
  case recommendedMovies
}
