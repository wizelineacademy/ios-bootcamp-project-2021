//
//  SimilarMovie.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

struct ListSimilarOrRecommendedMovies: Decodable {
  let results: [Movie]?
}
