//
//  CreditsMovie.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 1/11/21.
//

import Foundation

struct CreditsMovie: Decodable {
    var id: Int?
    var cast: [Person]?
    var crew: [Person]?
}
