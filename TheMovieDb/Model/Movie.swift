//
//  Movie.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 25/10/21.
//

import Foundation

struct Movie: Codable {
    var posterPath: String?
    var overview: String?
    var genresIds: [Int]?
    var id: Int?
    var originalTitle: String?
    var title: String?
    var originalLanguage: String?
    var popularity: Double?
    var adult: Bool?
    var releaseDate: String?
}


