//
//  EndPoint.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 31/10/21.
//

import Foundation

protocol EndPoint {
    var base: String { get }
    var params: [String: String] { get set }
    func getPath(searchId: String?) -> String
}

extension EndPoint {
    func getRequest(id: String? = nil) -> URLRequest {
        let url = getUrlComponents(movieId: id).url!
        return URLRequest(url: url)
    }
    
    func getUrlComponents(movieId: String? = nil) -> URLComponents {
        var components = URLComponents(string: base)!
        components.path = getPath(searchId: movieId)
        components.queryItems = params.map({ return URLQueryItem(name: $0.key, value: $0.value) })
        return components
    }
}
