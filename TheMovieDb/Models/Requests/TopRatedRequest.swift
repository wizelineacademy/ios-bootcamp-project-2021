//
//  TopRatedRequest.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 31/10/21.
//

import Foundation

struct TopRatedRequest: Request, PageableModel {
    
    var page: Int = 1
    
    var base: String {
        return EndpointConstants.baseURL
    }
    
    var endpoint: String {
        return EndpointConstants.topRated
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
    
    var jsonMock: String? {
        return "top_rated_mock"
    }
}
