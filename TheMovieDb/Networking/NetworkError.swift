//
//  NetworkError.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 27/10/21.
//

import Foundation

enum NetworkError: Error {
  case invalidURL
  case noData
  case networkError(error: Error?)
}

extension NetworkError {
  var mensaje: String {
    switch self {
    case .invalidURL, .noData:
      return "Error"
    case .networkError(let error):
        return error?.localizedDescription ?? ""
    }
  }
  
}
