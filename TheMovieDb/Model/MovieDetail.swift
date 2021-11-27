//
//  MovieDetail.swift
//  TheMovieDb
//
//  Created by developer on 17/11/21.
//
import Foundation

protocol MovieDetailProtocol: MovieProtocol {
    var originalTitle: String { get set }
    var releaseDate: String { get set }
    var popularity: Double { get set }
}

struct MovieDetail: MovieDetailProtocol, Decodable {
    var originalTitle: String
    var releaseDate: String
    var popularity: Double
    var title: String
    var id: Int
    var posterPath: String?
    var overview: String
}
