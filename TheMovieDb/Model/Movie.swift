//
//  Movie.swift
//  TheMovieDb
//
//  Created by developer on 01/11/21.
//

import Foundation

protocol MovieProtocol {
    var title: String { get set }
    var id: Int { get set }
    var posterPath: String? { get set }
    var overview: String { get set }
}

struct Movie: MovieProtocol, Decodable {
    var title: String
    var id: Int
    var posterPath: String?
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
