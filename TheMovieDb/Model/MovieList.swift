//
//  MovieList.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 31/10/21.
//

import Foundation

struct MovieList: Decodable {
    let results: [MovieItem]?
}
