//
//  Movie.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 02/12/21.
//

import Foundation

struct Movie: Decodable, Hashable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String?
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
    
}
