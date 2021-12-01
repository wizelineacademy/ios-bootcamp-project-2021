//
//  EndPoint.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 31/10/21.
//

import Foundation

protocol EndPoint {
    var base: String { get }
    var defaultParams: [String: String] { get set }
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
        components.queryItems = addParams(params: defaultParams)
        components.queryItems?.append(contentsOf: addParams(params: params))
        return components
    }
    
    private func addParams(params: [String: String]) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        for param in params {
            queryItems.append(URLQueryItem(name: param.key, value: param.value)
            )
        }
        return queryItems
    }
}
