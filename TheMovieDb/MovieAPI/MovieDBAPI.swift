//
//  TrendingRequest.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 27/10/21.
//

import Foundation

struct MovieDBAPI {
    static let baseUrl = "https://api.themoviedb.org/3"
    static let apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    struct GetTrendingMovies: RequestType {
        typealias ResponseType = MovieListResponse
        
        var data = RequestData(
            path: "\(MovieDBAPI.baseUrl)/trending/movie/day",
            queryParams: [
                "api_key": MovieDBAPI.apiKey,
                "language": "en",
                "region": "US"
            ]
        )
    }
    
    struct GetNowPlayingMovies: RequestType {
        typealias ResponseType = MovieListResponse
        
        var data = RequestData(
            path: "\(MovieDBAPI.baseUrl)/movie/now_playing",
            queryParams: [
                "api_key": MovieDBAPI.apiKey,
                "language": "en",
                "region": "US"
            ]
        )
    }
    
    struct GetPopularMovies: RequestType {
        typealias ResponseType = MovieListResponse
        
        var data = RequestData(
            path: "\(MovieDBAPI.baseUrl)/movie/popular",
            queryParams: [
                "api_key": MovieDBAPI.apiKey,
                "language": "en",
                "region": "US"
            ]
        )
    }
    
    struct GetTopRatedMovies: RequestType {
        typealias ResponseType = MovieListResponse
        
        var data = RequestData(
            path: "\(MovieDBAPI.baseUrl)/movie/top_rated",
            queryParams: [
                "api_key": MovieDBAPI.apiKey,
                "language": "en",
                "region": "US"
            ]
        )
    }
    
    struct GetUpcomingMovies: RequestType {
        typealias ResponseType = MovieListResponse
        
        var data = RequestData(
            path: "\(MovieDBAPI.baseUrl)/movie/upcoming",
            queryParams: [
                "api_key": MovieDBAPI.apiKey,
                "language": "en",
                "region": "US"
            ]
        )
    }
}
