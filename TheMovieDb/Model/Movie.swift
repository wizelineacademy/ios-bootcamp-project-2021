//
//  Results.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 27/10/21.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String?
    let name: String?
    let video: Bool?
    let vote_average: Float?
    let overview: String?
    let release_date: String?
    let vote_count: Int?
    let adult: Bool?
    let backdrop_path: String?
    let poster_path: String?
    let popularity: Float?
    let media_type: String?
         
}
