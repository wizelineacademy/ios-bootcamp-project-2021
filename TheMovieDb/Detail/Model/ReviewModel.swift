//
//  ReviewModel.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 09/11/21.
//

import Foundation

struct ReviewModel: Codable, Hashable {
    let author: String?
    let content: String
}
