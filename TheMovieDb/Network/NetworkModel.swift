//
//  NetworkModel.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 31/10/21.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol Request {
    var base: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var query: [String: String]? { get }
    var params: Encodable? { get }
    var decodingKey: JSONDecoder.KeyDecodingStrategy { get }
}

extension Request {
    var method: HTTPMethod {
        return .get
    }
    
    var contentType: String {
        return "application/json"
    }
    
    var query: [String: String]? {
        return nil
    }
    
    var params: Encodable? {
        return nil
    }
    
    var urlComponents: URLComponents? {
        var components = URLComponents(string: base)
        components?.path = endpoint
        components?.queryItems = query?.map({ (key: String, value: String) in
            let escapedQuery = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            return URLQueryItem(name: key, value: escapedQuery)
        })
        return components
    }
    
    var urlEndpoint: URLRequest? {
        let url = urlComponents?.url
        guard let url = url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = params?.toData()
        return request
    }
    
    var decodingKey: JSONDecoder.KeyDecodingStrategy {
        return .useDefaultKeys
    }
}

public protocol PageableView {
    var page: Int { get }
    func nextPage()
    func clearPages()
}

public protocol PageableModel {
    var page: Int { get }
    mutating func nextPage()
    mutating func clearPages()
}

extension Encodable {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
