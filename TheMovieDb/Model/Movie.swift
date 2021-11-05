//
//  Results.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 27/10/21.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let video: Bool
    let voteAverage: Float
    let overview: String
    let releaseDate: String
    let voteCount: Int
    let adult: Bool
    let backdropPath: String?
    let posterPath: String?
    let popularity: Float
    let mediaType: String?
    
}
