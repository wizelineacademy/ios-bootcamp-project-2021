//
//  MovieData.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 31/10/21.
//

import Foundation


struct MoviesData: Decodable {
    let page: Int?
    let results: [Movie]
    let totalPages: Int?
    let totalResults: Int?
    
}

struct Movie: Decodable {
    
    let id: Int?
    let originalTitle: String?
    let releaseDate: String?
    let voteAverage: Double?
    let posterPath: String?
    let overview: String?
    let backdropPath: String?
    
}

struct ReviewsData: Decodable {
    let results: [Reviews]
}

struct Reviews: Decodable{
    let author: String?
    let content: String?
}


