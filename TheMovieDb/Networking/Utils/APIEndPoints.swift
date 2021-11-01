//
//  Const.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 27/10/21.
//

enum APIEndPoints: String {
    case trending = "/trending/movie/day"
    case nowPlaying = "/movie/now_playing"
    case popular = "/movie/popular"
    case topRated = "/movie/top_rated"
    case upcoming = "/movie/upcoming"
    case keyword = "/search/keyword"
    case search = "/search/movie"
    case review = "/movie/[id]/reviews"
    case similar = "/movie/[id]/similar"
    case recommendations = "/movie/[id]/recommendations"
    
}
