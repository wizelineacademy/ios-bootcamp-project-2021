//
//  MovieModel.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 31/10/21.
//

import Foundation

struct PageModel<T: Decodable>: Decodable {
    let results: [T]
    let totalPages: Int
}

struct MovieModel: Decodable, Hashable {
    let id: Int?
    let title: String?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Float?
    let overview: String?
    let popularity: Float?
    let voteCount: Int?
}
