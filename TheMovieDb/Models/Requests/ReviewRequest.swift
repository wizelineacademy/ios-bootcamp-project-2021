//
//  ReviewRequest.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 09/11/21.
//

import Foundation

struct ReviewRequest: Request, PageableModel {
    
    private let id: Int
    
    var base: String {
        return EndpointConstants.baseURL
    }
    
    var endpoint: String {
        return EndpointConstants.reviews(id: id)
    }
    
    var page: Int = 1
    
    var query: [String : String]? {
        return [
            "api_key": apiKey,
            "language": "en",
            "region": "US",
            "page": String(page)
        ]
    }
    
    var decodingKey: JSONDecoder.KeyDecodingStrategy {
        return JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase
    }
    
    init(id: Int) {
        self.id = id
    }
}
