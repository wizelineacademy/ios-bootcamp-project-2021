//
//  APIRequest.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 03/11/21.
//

import Foundation

public protocol MovieDBAPIRequest {
    var baseURL : String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var query: Query { get }
    var parameters: Parameters? { get }
    var headers: [String: String]? { get }
}

extension MovieDBAPIRequest {
    func defaultJSONHeaders() -> [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
}
