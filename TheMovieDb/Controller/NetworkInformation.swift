//
//  NetworkInformation.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 29/10/21.
//

import Foundation

enum MovieListEndpoint {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    var path: String {
        switch self {
        case .trending: return "trending/movie/week"
        case .nowPlaying: return "movie/now_playing"
        case .popular: return "movie/popular"
        case .topRated: return "movie/top_rated"
        case .upcoming: return "movie/upcoming"
        }
    }
}

protocol QueryParams {
    static var apiKey: String { get set }
    static var language: String { get set }
}

enum HTTPMethod: String {
    case get, post, put, patch, delete, options, head
}

enum MovieError: Error {
    case invalidUrl
    case wrongResponse
    case unknownError(error: Error)
}

protocol MovieService {
    static func getMovies(endpoint: MovieListEndpoint, returnMovies: @escaping (Result<MovieResponse, MovieError>) -> Void)
}


