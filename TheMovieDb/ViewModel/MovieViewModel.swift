//
//  MovieViewModel.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 22/11/21.
//

import Foundation

struct MovieViewModel: Hashable {
    let id: Int
    let title: String
    let image: URL?
    let originalTitle, overview, releaseDate: String
    let voteAverage: String
    let voteCount: String
    let popularity: String
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }

    static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
      return lhs.identifier == rhs.identifier
    }

    private let identifier = UUID()
    
}

extension MovieViewModel {
    init(movie: Movie) {
        
        self.title = movie.title ?? ""
        self.id = movie.id ?? 0
        self.originalTitle = movie.originalTitle ?? ""
        self.overview = movie.overview ?? ""
        self.releaseDate = movie.releaseDate ?? ""
        self.voteCount = String(movie.voteCount ?? 0)
        self.voteAverage = String(movie.voteAverage ?? 0)
        self.popularity = String(movie.popularity ?? 0)
        
        if let portraitPhotoURL = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(portraitPhotoURL)") {
            self.image = url
        } else {
            self.image = nil
        }
    }
}
