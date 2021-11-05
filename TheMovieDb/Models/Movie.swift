//
//  Movie.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 01/11/21.
//

import Foundation

struct Results<T: Decodable>: Decodable {
    let page: Int
    let results: [T]
}

struct Movie: Decodable, Hashable {
    
    let id: Int
    let title: String
    let voteAverage: Decimal
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let overview: String
    let originalLanguage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case overview
        case originalLanguage = "original_language"
    }
}

struct MovieList: Decodable {
    let page: Int
    let results : [Movie]
}

