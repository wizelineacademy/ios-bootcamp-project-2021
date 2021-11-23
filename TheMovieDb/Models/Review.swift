//
//  Review.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 09/11/21.
//

import Foundation

struct Review: Decodable, Identifiable {
    var author: String
    let content: String
    let id: String
}
