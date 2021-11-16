//
//  Constants.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 07/11/21.
//

import Foundation

struct Constants  { //constants
    static let cellIdentifier: String = "ReusableCell"
    static let cellXibName: String = "MovieCell"
    static let segueIdentifier: String = "showDetail"
    
    struct MovieLaunch {
        static let nowPlaying: String = "now_playing"
        static let popular: String = "popular"
        static let topRated: String = "top_rated"
        static let upcoming: String = "upcoming"
        static let trending: String = "trending"
    }
    
    struct URLS{
        static let imageURL: String = "https://image.tmdb.org/t/p/w500"
        static let movieBaseURL: String = "https://api.themoviedb.org/3"
        static let apiKey: String = "444cd656b00475d785aa41a9c43b2e44"
    }
}
