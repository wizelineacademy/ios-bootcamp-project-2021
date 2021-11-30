//
//  SearchRequest.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 02/11/21.
//

import Foundation

struct SearchRequest: Request, PageableModel, SearchableModel {
    
    var page: Int = 1
    var search: String = ""
    
    var base: String {
        return EndpointConstants.baseURL
    }
    
    var endpoint: String {
        return EndpointConstants.search
    }
    
    var query: [String : String]? {
        return [
            "api_key": apiKey,
            "language": "en",
            "region": "US",
            "page": String(page),
            "query": search
        ]
    }
    
    var decodingKey: JSONDecoder.KeyDecodingStrategy {
        return .convertFromSnakeCase
    }
}
