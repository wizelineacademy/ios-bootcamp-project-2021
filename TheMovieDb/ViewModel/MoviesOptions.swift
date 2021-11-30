//
//  MoviesOptions.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 12/11/21.
//

import Foundation

enum MoviesOptions: String, CaseIterable {
    case trending = "trending"
    case nowPlaying = "now.playing"
    case popular = "popular"
    case topRated = "top.rated"
    case upcoming = "upcoming"
    
    var title: String { rawValue.localized }
}
