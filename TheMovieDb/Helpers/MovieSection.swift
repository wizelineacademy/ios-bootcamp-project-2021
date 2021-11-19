//
//  MovieSection.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/13/21.
//

import Foundation

enum MovieSection: CaseIterable {
  case extrainfo, overview, cast, reviews, similar, recommended
}

extension MovieSection {
  var title: String {
    switch self {
    case .extrainfo: return "Extrainfo"
    case .overview: return "Overview"
    case .cast: return "Cast"
    case .reviews: return "Reviews"
    case .similar: return "Similar Movies"
    case .recommended: return "Recommended Movies"
    }
  }
}
