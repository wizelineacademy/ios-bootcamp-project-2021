//
//  MovieViewModel.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/21/21.
//
import UIKit
import Combine

struct MovieViewModel {
  
  private let movie: Movie
  
  init(movie: Movie) {
    self.movie = movie
  }
  
  var id: Int { movie.id }
  var title: String { movie.title }
  
  var poster: String? {
    let url: String?
    guard let portrait = movie.poster else { return nil }
    url = "\(ApiPath.baseUrlImage.path)\(portrait)"
    return url
  }
  
}
