//
//  MovieData.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 31/10/21.
//

import Foundation


import Foundation

struct MoviesData: Decodable {
    let results: [Movie]
    
}

struct Movie: Decodable {
    
    let id: Int?
    let originalTitle: String?
    let releaseDate: String?
    let voteAverage: Double?
    let posterPath: String?
    let overview: String?
    let backdropPath: String?
    let genres: [Genre]?
    
}

struct Genre: Decodable {
    let id: Int?
    let name: String
}



//May wanna change this

/*struct MovieInfo: Decodable {
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

}*/
