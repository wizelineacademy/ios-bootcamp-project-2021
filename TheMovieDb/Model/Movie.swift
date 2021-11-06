//
//  Movie.swift
//  TheMovieDb
//
//  Created by developer on 01/11/21.
//

import Foundation

struct Movie: Decodable {
    var title: String
    var id: Int
    var posterPath: String
    var overview: String
}

protocol ModelListProtocol: Decodable {
    associatedtype ListTypes
    var results: [ListTypes] { get set }
}

struct MovieList: ModelListProtocol {
    typealias ListTypes = Movie
    var results: [Movie]
}
