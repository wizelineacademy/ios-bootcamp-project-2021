//
//  MovieFeedResults.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

struct MovieFeedResult: Decodable {
    let results: [Movie]?
}
