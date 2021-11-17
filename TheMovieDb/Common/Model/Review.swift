//
//  Review.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 27/10/21.
//
import Foundation

struct Review: Decodable {
    let id: String
    let author: String
    let content: String
    let createdAt: String
    let updatedAt: String
    let url: String
    let authorDetails: AuthorReview
}
