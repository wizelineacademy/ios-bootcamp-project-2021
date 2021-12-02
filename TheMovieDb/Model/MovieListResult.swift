//
//  MovieListResult.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 31/10/21.
//

import Foundation

// MARK: - MovieListResult
struct MovieListResult: Decodable {
    let results: [MovieItem]?
}

// MARK: - MovieItem
struct MovieItem: Decodable {
    let id: Int?
    let originalTitle: String?
    let posterPath: String?
    let video: Bool?
    let voteAverage: Double?
    let overview: String?
    let releaseDate: String?
    let voteCount: Int?
    let adult: Bool?
    let title: String?
    let genreIDS: [Int]?
    let backdropPath: String?
    let originalLanguage: String?
    let popularity: Double?
    let mediaType: String?

    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case video
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case adult
        case id
        case title
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case popularity
        case mediaType = "media_type"
    }
}
