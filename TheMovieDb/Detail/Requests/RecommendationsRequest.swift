//
//  RecommendationsRequest.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 11/11/21.
//

import Foundation

struct RecommendationsRequest: Request, PageableModel {
    
    private let id: Int
    
    var page: Int = 1
    
    var base: String {
        return EndpointConstants.baseURL
    }
    
    var endpoint: String {
        return EndpointConstants.recommendations(id: id)
    }
    
    var query: [String : String]? {
        return [
            "api_key": apiKey,
            "language": "en",
            "region": "US",
            "page": String(page)
        ]
    }
    
    var decodingKey: JSONDecoder.KeyDecodingStrategy {
        return .convertFromSnakeCase
    }
    
    init(id: Int) {
        self.id = id
    }
}
