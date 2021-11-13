//
//  EndpointConstants.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 31/10/21.
//

import Foundation

enum EndpointConstants {
    static var baseURL: String {
        return "https://api.themoviedb.org"
    }
    
    static var trending: String {
        return "/3/trending/movie/day"
    }
    
    static var nowPlaying: String {
        return "/3/movie/now_playing"
    }
    
    static var popular: String {
        return "/3/movie/popular"
    }
    
    static var topRated: String {
        return "/3/movie/top_rated"
    }
    
    static var upcoming: String {
        return "/3/movie/upcoming"
    }
    
    static var search: String {
        return "/3/search/movie"
    }
    
    static func reviews(id: Int) -> String {
        let id: String = String(id)
        return "/3/movie/\(id)/reviews"
    }
    
    static func recommendations(id: Int) -> String {
        let id: String = String(id)
        return "/3/movie/\(id)/recommendations"
    }
}
