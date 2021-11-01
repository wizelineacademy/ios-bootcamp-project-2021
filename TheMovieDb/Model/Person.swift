//
//  Person.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 31/10/21.
//

import Foundation

struct Person: Decodable {
    var adult: Bool?
    var gender: Int?
    var id: Int?
    var knownFor: [Movie]?
    var knownForDepartment: String?
    var name: String?
    var popularity: Double?
    var profilePath: String?
}
