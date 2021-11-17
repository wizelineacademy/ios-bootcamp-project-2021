//
//  SearchKeyword.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/15/21.
//

import Foundation

enum SearchKeyword {
  case keywords(String)
}

extension SearchKeyword: Endpoint {
  var path: String {
    switch self {
    case .keywords(let word): return "/3/search/\(word)"
    }
  }
}
