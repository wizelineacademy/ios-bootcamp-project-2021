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
    var urlString: String {
        base + path
    }
    
    var urlComponents: URLComponents {
        let components = URLComponents(string: base + path)!
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
