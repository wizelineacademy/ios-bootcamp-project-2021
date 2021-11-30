//
//  Person.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 31/10/21.
//

import Foundation

struct Person: Decodable {
    var id: Int?
    var biography: String?
    var knownForDepartment: String?
    var name: String?
    var popularity: Double?
    var profilePath: String?
    var birthday: String?
    var deathday: String?
}
