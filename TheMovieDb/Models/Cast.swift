//
//  Person.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 28/11/21.
//

import Foundation

struct Cast: Decodable, Hashable, Identifiable {
    let adult: Bool
    let gender: Int?
    let id: Int
    let name: String
    let originalName: String
    let character: String
    let creditId: String
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case name
        case originalName = "original_name"
        case character
        case creditId = "credit_id"
        case order
    }
}
