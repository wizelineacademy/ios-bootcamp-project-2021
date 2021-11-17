//
//  TextStyle.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/2/21.
//

import UIKit

// MARK: enum for manage the text style in the app

enum TextStyle {
  
  case title, subtitle, headline, subheadline, caption, paragraph
  
  var size: CGFloat {
    switch self {
    case .title: return 24
    case .subtitle: return 18
    case .headline: return 20
    case .subheadline: return 16
    case .caption: return 12
    case .paragraph: return 14
    }
  }
}
