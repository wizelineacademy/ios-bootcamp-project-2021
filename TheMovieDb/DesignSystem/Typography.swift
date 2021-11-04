//
//  Typography.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/2/21.
//

import Foundation
import UIKit

enum TextStyle {
  
  case title, subtitle, headline, subheadline, caption, paragraph
  
  var size: CGFloat {
    switch self {
    case .title: return 22
    case .subtitle: return 20
    case .headline: return 18
    case .subheadline: return 16
    case .caption: return 12
    case .paragraph: return 14
    }
  }
}
