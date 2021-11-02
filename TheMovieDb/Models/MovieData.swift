//
//  MovieData.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 31/10/21.
//

import Foundation

//May wanna change this

struct MovieInfo: Decodable {
    let id: Int?
    let poster_path: String?
    let title: String?
    let overview: String?
    let release_date: String?
    let vote_average: Double?
}


struct Genre: Decodable {
    let id: Int?
    let name: String?
}

struct MovieData: Decodable {
    let id: Int?
    let title: String?
    let poster_path: String?
    let backdrop_path: String?
    let overview: String?
    let release_date: String?
    let status: String?
    let vote_average: Double?
    let genres: [Genre]
    
}

struct MovieResults: Decodable {
    let page: Int?
    let numResults: Int?
    let numPages: Int?
    var movies: [MovieInfo]
    

    private enum CodingKeys: String, CodingKey {
    case page, numResults = "total_results", numPages = "total_pages", movies = "results" }

}
