//
//  Constants.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 07/11/21.
//

import Foundation

struct Constants {
    static let cellIdentifier: String = "ReusableCell"
    static let cellXibName: String = "MovieCell"
    static let mainViewControllerName: String = "MainViewController"
    static let searchViewControllerName: String = "SearchViewController"
    static let detailViewControllerName: String = "DetailViewController"
    static let storyboardName: String = "Main"
    
    struct MovieControl {
        static let nowPlaying: String = "/3/movie/now_playing"
        static let popular: String = "/3/movie/popular"
        static let topRated: String = "/3/movie/top_rated"
        static let upcoming: String = "/3/movie/upcoming"
        static let trending: String = "/3/trending/movie/day"
        static let search: String = "/3/search/movie"
    }
    
    struct URLS {
        static let imageURL: String = "https://image.tmdb.org/t/p/w500"
        static let movieBaseURL: String = "https://api.themoviedb.org"
        static let apiKeyQuery: String = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        static let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    }
    
    struct Errors {
        static let requestFailed: String = "Request Failed"
        static let InvalidData: String = "Invalid Data"
        static let responseUnsuccessful: String = "Response Unsuccessful"
        static let jsonParsingFailure: String = "JSON Parsing Failure"
        static let jsonConversionFailure: String = "JSON Conversion Failure"
        
    }
}
