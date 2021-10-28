//
//  Movie.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 25/10/21.
//

import Foundation

struct Movie: Codable {
    let posterPath: String?
    let adult: Bool
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    let id: Int
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let backdrop_path: String?
    let popularity: Float
    let voteCount: Int
    let video: Bool
    let voteAverage: Float
}
