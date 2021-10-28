//
//  MovieResponse.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 25/10/21.
//

import Foundation

struct MovieResponse: Decodable {
    var page: Int?
    var results: [Movie]?
    var totalPages: Int?
    var totalResults: Int?
}
