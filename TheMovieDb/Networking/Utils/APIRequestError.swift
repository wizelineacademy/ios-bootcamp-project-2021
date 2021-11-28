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
        case .invalidRequest: return APIErrorConst.invalidRequest
        case .badRequest: return APIErrorConst.badRequest
        case .unauthorized: return APIErrorConst.unauthorized
        case .forbidden: return APIErrorConst.forbidden
        case .notFound: return APIErrorConst.notFound
        case .error4xx: return APIErrorConst.error4xx
        case .serverError: return APIErrorConst.serverError
        case .error5xx: return APIErrorConst.error5xx
        case .decodingError: return APIErrorConst.decodingError
        case .urlSessionFailed: return APIErrorConst.urlSessionFailed
        case .unknownError: return APIErrorConst.unknownError
        }
    }
}
