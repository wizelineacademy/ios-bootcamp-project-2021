//
//  Const.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 27/10/21.
//

enum APIEndPoints: String {
    case TRENDING = "/trending/movie/day"
    case NOW_PLAYING = "/movie/now_playing"
    case POPULAR = "/movie/popular"
    case TOP_RATED = "/movie/top_rated"
    case UPCOMING = "/movie/upcoming"
    case KEYWORD = "/movie/keyword"
    case SEARCH = "/search/movie"
    case REVIEWS = "/movie/[id]/reviews"
    case SIMILAR = "/movie/[id]/similar"
    case RECOMMENDATIONS = "/movie/[id]/recommendations"
    
}
