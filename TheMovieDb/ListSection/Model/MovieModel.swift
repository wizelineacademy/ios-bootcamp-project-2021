//
//  MovieModel.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 31/10/21.
//

import Foundation

struct PageModel: Decodable {
    let results: [MovieModel]
}

struct MovieModel: Decodable {
    let title: String?
    let posterPath: String?
    let voteAverage: Float?
    let overview: String?
}
