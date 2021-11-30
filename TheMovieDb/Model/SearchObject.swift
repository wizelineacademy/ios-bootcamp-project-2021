//
//  Searchable.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 31/10/21.
//

import Foundation

struct SearchObject: Decodable {
    var id: Int?
    var name: String?
    var title: String?
    var mediaType: String?
}

enum MediaType: String {
    case person
    case movie
    case tv
}
