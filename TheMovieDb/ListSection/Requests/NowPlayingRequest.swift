//
//  NowPlayingRequest.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 31/10/21.
//

import Foundation

struct NowPlayingRequest: Request, PageableModel {
    
    private(set) var page: Int = 1
    
    var base: String {
        return EndpointConstants.baseURL
    }
    
    var endpoint: String {
        return EndpointConstants.nowPlaying
    }
    
    var query: [String : String]? {
        return [
            "api_key": "f6cd5c1a9e6c6b965fdcab0fa6ddd38a",
            "language": "en",
            "region": "US",
            "page": String(page)
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
}
