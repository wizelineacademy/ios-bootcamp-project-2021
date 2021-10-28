//
//  MovieListResponse.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 27/10/21.
//

import Foundation

struct MovieListResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}
