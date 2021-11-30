//
//  Request.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 27/10/21.
//

import Foundation

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParams: [String: String]? { get set }
    var params: [String: Any?]? { get }
    var headers: [String: String]? { get }
    associatedtype ResponseType: Decodable
}

extension Request {
    var method: HTTPMethod { return .get }
    var queryParams: [String: String]? { return nil }
    var params: [String: Any?]? { return nil }
    var headers: [String: String]? { return nil }
}

extension Request {
    func asURLRequest() -> URLRequest? {
        guard var urlComponents = URLComponents(string: path) else {
            return nil
        }
        urlComponents.queryItems = queryParams?.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        guard let url = urlComponents.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
    
    mutating func addNewQueryParam(_ value: String, forKey key: String) {
        queryParams?[key] = value
    }
}
