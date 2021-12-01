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

//https://api.themoviedb.org/3/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&page=1
//https://api.themoviedb.org/3/movie/now_playing&page=3?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a

//https://api.themoviedb.org/3/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&page=2
