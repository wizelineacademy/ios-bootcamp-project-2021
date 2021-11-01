//
//  ListRecommendedMovies.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

struct ListRecommendedMovies: Decodable{
  let results: [RecommendedMovie]?
}
