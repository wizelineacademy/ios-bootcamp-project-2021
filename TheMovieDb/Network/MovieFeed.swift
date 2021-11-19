//
//  MovieFeed.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 18/11/21.
//

import Foundation

enum MovieFeed {
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case trending
}
extension MovieFeed: Endpoint {    
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .nowPlaying: return "/3/movie/now_playing"
        case .popular: return "/3/movie/popular"
        case .topRated: return "/3/movie/top_rated"
        case .upcoming: return "/3/movie/upcoming"
        case .trending: return "/3/trending/movie/day"
        }
    }
}
