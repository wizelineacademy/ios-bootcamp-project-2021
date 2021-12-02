//
//  MovieFeed.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 18/11/21.
//

import Foundation

enum MovieFeed {
    case nowPlaying(Int)
    case popular(Int)
    case topRated(Int)
    case upcoming(Int)
    case trending(Int)
}

extension MovieFeed: Endpoint {    
    
    var base: String {
        return Constants.URLS.movieBaseURL
    }
    
    // MARK: - Ternaries for Control Pagination
    
    var path: String {
        switch self {
        case .nowPlaying(let page):
            let base = Constants.MovieControl.nowPlaying + Constants.URLS.apiKeyQuery
            return page > 0 ? base + "&page=\(page)" : base
        case .popular(let page):
            let base = Constants.MovieControl.popular + Constants.URLS.apiKeyQuery
            return page > 0 ? base + "&page=\(page)" : base
        case .topRated(let page):
            let base = Constants.MovieControl.topRated + Constants.URLS.apiKeyQuery
            return page > 0 ? base + "&page=\(page)" : base
        case .upcoming(let page):
            let base = Constants.MovieControl.upcoming + Constants.URLS.apiKeyQuery
            return page > 0 ? base + "&page=\(page)" : base
        case .trending(let page):
            let base = Constants.MovieControl.trending + Constants.URLS.apiKeyQuery
            return page > 0 ? base + "&page=\(page)" : base
        }
    }
    
}
