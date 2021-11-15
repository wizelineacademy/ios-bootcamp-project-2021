//
//  ApiPath.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/5/21.
//

import Foundation

enum ApiPath {
  case baseUrl, baseUrlImage, baseUrlImageW780, baseUrlImageW1280, apiKey
}

extension ApiPath {
  var path: String {
    switch self {
    case .apiKey: return "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    case .baseUrl: return "https://api.themoviedb.org"
    case .baseUrlImage: return "https://image.tmdb.org/t/p/w500/"
    case .baseUrlImageW780: return "https://image.tmdb.org/t/p/w780/"
    case .baseUrlImageW1280: return "https://image.tmdb.org/t/p/w1280/"
    }
  }
}
