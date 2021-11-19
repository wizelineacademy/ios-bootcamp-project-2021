//
//  ApiPath.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/5/21.
//

import Foundation

enum ApiPath {
  case baseUrl, baseUrlImage, apiKey
}

extension ApiPath {
  var path: String {
    switch self {
    case .apiKey: return "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    case .baseUrl: return "https://api.themoviedb.org"
    case .baseUrlImage: return "https://image.tmdb.org/t/p/w500/"
    }
  }
}
