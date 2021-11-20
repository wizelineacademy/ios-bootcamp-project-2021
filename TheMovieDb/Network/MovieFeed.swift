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
        return Constants.URLS.movieBaseURL
    }
    
    var path: String {
        switch self {
        case .nowPlaying: return Constants.MovieControl.nowPlaying
        case .popular: return Constants.MovieControl.popular
        case .topRated: return Constants.MovieControl.topRated
        case .upcoming: return Constants.MovieControl.upcoming
        case .trending: return Constants.MovieControl.trending
        }
    }
}
