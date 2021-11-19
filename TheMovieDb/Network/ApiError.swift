//
//  ApiError.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

enum ApiError: Error {
  case requestFailed
  case jsonConversionFailure
  case invalidData
  case responseUnsuccesful
  case jsonParsingFailure
}

extension ApiError {
  var localizedDescription: String {
    switch self {
    case .invalidData: return "Invalid Data"
    case .jsonConversionFailure: return "JSON Conversion Failed"
    case .jsonParsingFailure: return "JSON Parsing Failed"
    case .requestFailed: return "Request Failed"
    case .responseUnsuccesful: return "Response Unsuccessful"
    }
  }
}
