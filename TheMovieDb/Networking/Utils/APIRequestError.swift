//
//  APIRequestError.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 25/11/21.
//

import Foundation

enum APIRequestError: LocalizedError {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .invalidRequest: return "Invalid Request"
        case .badRequest: return "Bad Request"
        case .unauthorized: return "Unauthorized"
        case .forbidden: return "No Permission"
        case .notFound: return "Page not exist"
        case .error4xx: return "Error 400"
        case .serverError: return "The service is not working"
        case .error5xx: return "The service is not available"
        case .decodingError: return "Error in decoding data"
        case .urlSessionFailed: return "Error on URL"
        case .unknownError: return "Unknown Error"
        }
    }
}
