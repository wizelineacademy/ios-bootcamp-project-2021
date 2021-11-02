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
    case search
    case movieDetails(id: Int)
    case personDetails(id: Int)
    case similar(id: Int)
    case recommendations(id: Int)
    case reviews(id: Int)
    case credits(id: Int)
    
    var path: String {
        switch self {
        case .trending: return "trending/movie/week"
        case .nowPlaying: return "movie/now_playing"
        case .popular: return "movie/popular"
        case .topRated: return "movie/top_rated"
        case .upcoming: return "movie/upcoming"
        case .search: return "search/multi"
        case .movieDetails(let id): return "movie/\(id)"
        case .personDetails(let id): return "person/\(id)"
        case .similar(let id): return "movie/\(id)/similar"
        case .recommendations(let id): return "movie/\(id)/recommendations"
        case .reviews(let id): return "movie/\(id)/reviews"
        case .credits(let id): return "movie/\(id)/credits"
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
    static func get<T: Decodable>(search: String?, endpoint: MovieListEndpoint, returnResponse: @escaping (Result<T, MovieError>) -> Void)
}
