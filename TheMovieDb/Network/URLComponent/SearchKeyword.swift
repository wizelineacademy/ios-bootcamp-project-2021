//
//  SearchKeyword.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/15/21.
//

import Foundation

enum SearchKeyword {
  case keywords
}

extension SearchKeyword: Endpoint {
  var path: String {
    switch self {
    case .keywords: return "/3/search/movie"
    }
  }
}
