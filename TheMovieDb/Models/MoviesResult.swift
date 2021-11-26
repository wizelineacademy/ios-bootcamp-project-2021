//
//  MovieResults.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 01/11/21.
//

import Foundation

struct MoviesResult<T: Decodable>: Decodable {
    let page: Int?
    let results: [T]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}
