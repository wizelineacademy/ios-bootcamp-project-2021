//
//  Movie.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

struct Movie: Codable {
    
    let id: Int
    let title: String
    let poster: String
    let overview: String
    let releaseDate: String
    let voteAverage: Float
    let popularity: Float
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case poster = "poster_path"
        case releaseDate = "release_date"
        case overview
        case voteAverage = "vote_average"
        case popularity
        
    }
}
