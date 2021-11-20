//
//  Movie.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 25/10/21.
//

import Foundation

struct Movie: Decodable, Hashable {
    let posterPath: String?
    let overview: String
    let releaseDate: String
    let id: Int
    let title: String
}
