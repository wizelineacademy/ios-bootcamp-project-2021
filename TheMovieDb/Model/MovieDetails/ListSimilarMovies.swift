//
//  ListSimilarMovies.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

struct ListSimilarMovies: Decodable {
  let results: [SimilarMovie]?
}
