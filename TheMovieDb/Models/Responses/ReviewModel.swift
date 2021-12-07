//
//  ReviewModel.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 09/11/21.
//

import Foundation

struct ReviewModel: Codable, Hashable {
    let author: String?
    let authorDetails: AuthorDetail?
    let content: String
}

struct AuthorDetail: Codable, Hashable {
    let name: String?
    let username: String?
    let rating: Double?
    let avatarPath: String?
}
