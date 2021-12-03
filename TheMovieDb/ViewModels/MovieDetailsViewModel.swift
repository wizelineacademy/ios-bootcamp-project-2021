//
//  MovieDetailsViewModel.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/21/21.
//
import UIKit
import Combine

struct MovieDetailsViewModel {
  
  private var movieDetails: MovieDetails
  
  init(movieDetails: MovieDetails) {
    self.movieDetails = movieDetails
  }
  
  var id: Int { movieDetails.id }
  
  var title: String { movieDetails.title }
  
  var overview: String { movieDetails.overview }
  
  var originalLanguage: String { movieDetails.originalLanguage }
  
  var status: String { movieDetails.status }
  
  var releaseDate: String? { movieDetails.getMovieReleaseDateFormat() }
  
  var voteAverage: Float { movieDetails.voteAverage }
  
  var budget: String {
    movieDetails.getNumberFormat(dollars: movieDetails.budget)
  }
  
  var revenue: String {
    movieDetails.getNumberFormat(dollars: movieDetails.revenue)
  }
  
  var backDropPath: String? {
    let url: String?
    guard let moviePoster = movieDetails.backDropPath else { return nil }
    url = ApiPath.baseUrlImage.path + moviePoster
    return url
  }
  
}
