//
//  MovieData.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 31/10/21.
//

import Foundation


import Foundation

struct MoviesData: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
    }
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
