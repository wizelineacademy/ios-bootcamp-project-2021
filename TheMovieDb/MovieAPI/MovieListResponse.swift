//
//  MovieListResponse.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 27/10/21.
//

import Foundation

struct MovieDBAPIListResponse<Model: Decodable>: Decodable {
    let page: Int
    let results: [Model]
    let totalPages: Int
    let totalResults: Int
}
