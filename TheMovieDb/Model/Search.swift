//
//  Searches.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 28/10/21.
//

import Foundation

struct Search: Decodable {
    let results: [ResultSearch]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([ResultSearch].self, forKey: .results)
    }
}
