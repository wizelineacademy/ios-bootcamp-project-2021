//
//  MovieViewModel.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 28/11/21.
//

import Foundation

struct MovieViewModel {
  private let movie: Movie?
}

extension MovieViewModel {
  init(_ movie: Movie?) {
    self.movie = movie ?? nil
  }
}

extension MovieViewModel {
  
  var title: String {
    return self.movie?.title ?? ""
  }
  
  var score: Float {
    return self.movie?.voteAverage ?? 0
  }
  
  var posterPath: String {
    return self.movie?.posterPath ?? ""
  }
  
  var overview: String {
    return self.movie?.overview ?? ""
  }
  
  var id: Int {
    return self.movie?.id ?? 0
  }
}
