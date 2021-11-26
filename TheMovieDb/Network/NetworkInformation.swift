//
//  NetworkInformation.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 29/10/21.
//

import Foundation
import Combine

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

enum HTTPMethod: String {
    case get, post, put, patch, delete, options, head
}

struct RequestParams {
    static let apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    static let language = Locale.current.languageCode ?? "en"
}

enum MovieError: Error, Identifiable {
    
    case invalidUrl
    case invalidResponse
    case wrongResponse(status: Int)
    case unknownError(error: Error)
    case emptyResponse(list: String)
    
    
    var id: String {
        return titleError
    }
    
    var titleError: String {
        switch self {
        case .invalidUrl, .invalidResponse, .wrongResponse, .unknownError, .emptyResponse: return "Error"
        }
    }
    
    var messageError: String {
        switch self {
        case .invalidUrl: return "Invalid URL"
        case .invalidResponse: return "Unavailable Response"
        case .wrongResponse(let status): return "Service failured with status code \(status)"
        case .unknownError(let error): return "Error \(error.localizedDescription)"
        case .emptyResponse(let list): return String(format: "alert.empty.response".localized, list)
        }
    }
}

protocol MovieService {
    func get<T: Decodable>(type: T.Type, search: String?, endpoint: MovieListEndpoint) -> AnyPublisher<T, MovieError>
}
