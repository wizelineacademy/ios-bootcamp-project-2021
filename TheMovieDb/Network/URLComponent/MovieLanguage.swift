//
//  MovieLanguage.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

enum MovieLanguage {
  
  case en
  case es
  case pr
  case fr
  
}

extension MovieLanguage {
  
  var language: String {
    switch self {
    case .en: return "en"
    case .es: return "es"
    case .fr: return "fr"
    case .pr: return "pr"
    }
  }
}
