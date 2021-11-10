//
//  Constants.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 07/11/21.
//

import Foundation

struct Constant  { //constants
    static let cellIdentifier: String = "ReusableCell"
    static let cellXibName: String = "MovieCell"
    
    struct MovieLaunch {
        static let nowPlaying: String = "now_playing"
        static let popular: String = "popular"
        static let topRated: String = "top_rated"
        static let upcoming: String = "upcoming"
        static let trending: String = "trending"
    }
    
    struct URLS{
        static let imageURL: String = "https://image.tmdb.org/t/p/w500"
    }
}
