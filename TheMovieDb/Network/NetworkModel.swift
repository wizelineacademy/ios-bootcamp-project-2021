//
//  NetworkModel.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 31/10/21.
//

import Foundation

public enum NetworkError: Error {
    case requestFailed
    case jsonConversionFailed
    case invalidData
    case noResponse
    case jsonParsingFailed
    
    var localizedDescription: String {
        switch self {
        case .requestFailed:
            return "Request call failed."
        case .jsonConversionFailed:
            return "JSON conversion failed."
        case .invalidData:
            return "Data is not valid."
        case .noResponse:
            return "Service response failed."
        case .jsonParsingFailed:
            return "JSON parsing failed"
        }
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol Request {
    var base: String { get }
    var endpoint: String { get }
    var apiKey: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var query: [String: String]? { get }
    var params: Encodable? { get }
    var decodingKey: JSONDecoder.KeyDecodingStrategy { get }
    var jsonMock: String? { get }
}

extension Request {
    var apiKey: String {
        return "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    }
    
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
            let escapedQuery = value
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
        request.timeoutInterval = 15
        request.httpBody = params?.toData()
        return request
    }
    
    var decodingKey: JSONDecoder.KeyDecodingStrategy {
        return .useDefaultKeys
    }
    
    var jsonMock: String? {
        return nil
    }
}
