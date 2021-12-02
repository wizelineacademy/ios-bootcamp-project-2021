//
//  PathComposer.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 05/11/21.
//
// Class to compose the different paths possible to include on the request for MovieDb api

import Foundation

enum RequestPaths {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case keyword
    case search
    case reviews(movieId: Int)
    case similarMovies(movieId: Int)
    case recommendations(movieId: Int)
    case searchById(movieId: Int)
    case cast(movieId: Int)
    
    var path: String {
        switch self {
        case .trending:
            return "/3/trending/movie/day"
        case .nowPlaying:
            return "/3/movie/now_playing"
        case .popular:
            return "/3/movie/popular"
        case .topRated:
            return "/3/movie/top_rated"
        case .upcoming:
            return "/3/movie/upcoming"
        case .keyword:
            return "/3/search/keyword"
        case .search:
            return "/3/search/movie"
        case .reviews(movieId: let movieId):
            return "/3/reviews/" + String(movieId) + "/reviews"
        case .similarMovies(movieId: let movieId):
            return "/3/movie/" + String(movieId) + "/similar"
        case .recommendations(movieId: let movieId):
            return "/3/movie/" + String(movieId) + "/recommendations"
        case .searchById(movieId: let movieId):
            return "/3/movie/" + String(movieId)
        case .cast(movieId: let movieId):
            return "/3/movie/" + String(movieId) + "/credits"
        }
    }
}
