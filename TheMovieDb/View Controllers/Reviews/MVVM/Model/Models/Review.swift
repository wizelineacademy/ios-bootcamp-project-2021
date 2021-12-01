//
//  Review.swift
//  TheMovieDb
//
//  Created by developer on 30/11/21.
//

import Foundation

struct Review: ReviewProtocol, Decodable {
    var id: String?
    var author: String
    var content: String
}
