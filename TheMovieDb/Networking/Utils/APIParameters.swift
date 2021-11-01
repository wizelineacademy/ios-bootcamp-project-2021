//
//  Parameters.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 29/10/21.
//

import Foundation

struct APIParameters {
    var language = "&language="
    var region = "&region="
    var page = "&page="
    var query = "&query="
    let id: String
    
    init(language: String = "en", region: String = "US", page: String = "1", query: String = "Matrix", id: String = "603") {
        self.language += language
        self.region += region
        self.page += page
        self.query += query
        self.id = id
    }
    
}
