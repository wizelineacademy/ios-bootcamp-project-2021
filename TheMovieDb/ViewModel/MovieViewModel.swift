//
//  MovieViewModel.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 18/11/21.
//

import Foundation

struct MovieViewModel {
    let title: String
    let posterPath: String
    let mediaType: String
    let releaseDate: String
    let overview: String
    let rating: String
    let baseURL: String
    
    init(movie: MovieItem, configuration: ConfigurationImage) {
        self.title = movie.title ?? ""
        self.posterPath = movie.posterPath ?? ""
        self.mediaType = movie.mediaType ?? ""
        self.releaseDate = movie.releaseDate ?? ""
        self.overview = movie.overview ?? ""
        if let voteAverage = movie.voteAverage {
            self.rating = String(voteAverage)
        } else {
            self.rating = ""
        }
        self.baseURL = configuration.getSecureBasePosterURL()
    }
    
    lazy var posterURL: URL? = {
        return URL(string: baseURL + posterPath)
    }()
}
