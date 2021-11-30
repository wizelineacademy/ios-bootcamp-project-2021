//
//  ReviewsDetails.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 1/11/21.
//

import Foundation

struct ReviewsDetails: Decodable, Identifiable {
    var id: String?
    var author: String?
    var content: String?
}
