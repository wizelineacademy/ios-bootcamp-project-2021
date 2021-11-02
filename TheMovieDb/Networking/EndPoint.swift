//
//  EndPoint.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 31/10/21.
//

import Foundation

protocol EndPoint {
    var base: String { get }
    func getPath(searchId: String?) -> String
}

extension EndPoint {
    func getRequest(id: String? = nil, params: [String: String]) -> URLRequest {
        let url = getUrlComponents(movieId: id, params: params).url!
        return URLRequest(url: url)
    }
    
    func getUrlComponents(movieId: String? = nil, params: [String: String]) -> URLComponents {
        var components = URLComponents(string: base)!
        components.path = getPath(searchId: movieId)
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.apiKey)
        ]
        
        for param in params {
            components.queryItems?.append(
                URLQueryItem(name: param.key, value: param.value)
            )
        }
        
        return components
    }
}
