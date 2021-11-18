//
//  MovieDay.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 27/10/21.
//

import Foundation

struct Movies: Decodable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.movies = try container.decode([Movie].self, forKey: .movies)
    }
}
