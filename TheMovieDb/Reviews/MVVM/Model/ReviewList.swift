//
//  ReviewList.swift
//  TheMovieDb
//
//  Created by developer on 01/12/21.
//

import Foundation

struct ReviewsList: ReviwsListProtocol, Decodable {
    typealias ReviewsTypes = Review
    var results: [Review]
}
