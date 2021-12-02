//
//  Cast.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 28/11/21.
//

import Foundation

struct Credits: Decodable {
    let id: Int
    let cast: [Cast]
}
