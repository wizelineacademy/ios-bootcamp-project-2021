//
//  MovieList.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 05/11/21.
//

import Foundation

struct MovieList: Decodable {
    let page: Int
    let results: [Movie]
}
