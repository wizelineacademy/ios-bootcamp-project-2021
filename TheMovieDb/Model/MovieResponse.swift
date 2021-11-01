//
//  MovieResponse.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 25/10/21.
//

import Foundation

struct MovieResponse<T: Decodable>: Decodable {
    var page: Int?
    var results: [T]?
    var totalPages: Int?
    var totalResults: Int?
}
