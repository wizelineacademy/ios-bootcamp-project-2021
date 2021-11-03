//
//  SearchRequest.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 02/11/21.
//

import Foundation

struct SearchRequest: Request, PageableModel, SearchableModel {
    
    private(set) var page: Int = 1
    private(set) var search: String = ""
    
    var base: String {
        return EndpointConstants.baseURL
    }
    
    var endpoint: String {
        return EndpointConstants.search
    }
    
    var query: [String : String]? {
        return [
            "api_key": "f6cd5c1a9e6c6b965fdcab0fa6ddd38a",
            "language": "en",
            "region": "US",
            "page": String(page),
            "query": search
        ]
    }
    
    var decodingKey: JSONDecoder.KeyDecodingStrategy {
        return .convertFromSnakeCase
    }
    
    mutating func nextPage() {
        self.page += 1
    }
    
    mutating func clearPages() {
        self.page = 1
    }
    
    mutating func searchText(_ search: String) {
        self.search = search
    }
}
