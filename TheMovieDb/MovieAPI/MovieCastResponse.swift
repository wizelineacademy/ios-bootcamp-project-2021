//
//  MovieCastResponse.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 09/11/21.
//

import Foundation

struct MovieCastResponse: Decodable {
    let id: Int
    let cast: [CastMember]
}
