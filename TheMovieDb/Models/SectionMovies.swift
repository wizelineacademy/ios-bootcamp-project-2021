//
//  SectionMovies.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 11/11/21.
//

import Foundation

enum SectionMovie: String, CaseIterable {
    case trendingMovie = "Trending"
    case nowPlayingMovies = "Now Playing"
    case popularMovies = "Most Popular"
    case topRatedMovies = "Top"
    case upcomingMovies = "Upcoming Movies"
}
