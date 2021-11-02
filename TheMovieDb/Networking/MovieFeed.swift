//
//  MovieFeed.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 31/10/21.
//

import Foundation

enum MovieFeed: Int {
    case trending = 0
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case keyword
    case search
    case reviews
    case similar
    case recommendations
}

extension MovieFeed: EndPoint {
    var base: String {
        return Constants.apiBaseURL
    }
    
    func getPath(searchId: String?) -> String {
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
        case .reviews:
            return "/3/movie/\(searchId ?? "")/reviews"
        case .similar:
            return "/3/movie/\(searchId ?? "")/similar"
        case .recommendations:
            return "/3/movie/\(searchId ?? "")/recommendations"
        }
    }
}
