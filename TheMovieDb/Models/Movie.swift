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
    //let total_pages: Int
    //let total_results: Int
}

//struct Movie: Decodable {
//    let adult: Bool
//    let backdropPath: String?
//    let genres_id: [Int]
//    let id: Int
//    let original_language: String
//    let originalTitle: String
//
//    let overview: String
//    let posterPath: String?
//    let releaseDate: String
//    let title: String
//    let video: Bool
//    let voteAverage: Double
//    let voteCount: Int
//    let popularity: Double
//    let mediaType: String
//}
