//
//  APIError.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 18/11/21.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    var localizedDescription: String {
        switch self {
        case .requestFailed: return Constants.Errors.requestFailed
        case .invalidData: return Constants.Errors.InvalidData
        case .responseUnsuccessful: return Constants.Errors.responseUnsuccessful
        case .jsonParsingFailure: return Constants.Errors.jsonParsingFailure
        case .jsonConversionFailure: return Constants.Errors.jsonConversionFailure
        }
    }
}
