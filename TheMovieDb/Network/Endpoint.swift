//
//  Endpoint.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 18/11/21.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
}
extension Endpoint {
    var apiKey: String {
        return "api_key=\(Constants.URLS.apiKey)"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = apiKey
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
