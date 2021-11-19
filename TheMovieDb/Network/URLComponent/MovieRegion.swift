//
//  MovieRegion.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

enum MovieRegion {
  
  case US, CO, BR, MX, ES
  
}

extension MovieRegion {
  
  var region: String {
    switch self {
    case .BR: return "BR"
    case .CO: return "CO"
    case .ES: return "ES"
    case .MX: return "MX"
    case .US: return "US"
    }
  }
}
