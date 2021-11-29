//
//  MovieListViewModel.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 28/11/21.
//

import Foundation

struct  MovieListViewModel {
  let movies: [Movie]?
}

extension MovieListViewModel {
  init(_ movies: [Movie]?) {
    self.movies = movies
  }
  
}

extension MovieListViewModel {
  func numberRows() -> Int {
    return self.movies?.count ?? 0
  }
  
  func movieAtIndex(_ index: Int) -> MovieViewModel? {
    let movie = self.movies?[index]
    return MovieViewModel(movie)
  }
  
}
