//
//  URLRequestType.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 05/11/21.
//

import Foundation

enum URLRequestType: String {
    case topRated = "/3/movie/top_rated"
    case upcoming = "/3/movie/upcoming"
    case popular = "/3/movie/popular"
    case nowPlaying = "/3/movie/now_playing"
    case latest = "/3/movie/latest"
    
    var basePath: String {
        self.rawValue
    }
}
