//
//  DesignColor.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/2/21.
//

import UIKit

enum DesignColor {
  case black
  case darkGray
  case white
  case gray
  case lightGray
  case darkCyan
  case whiteDirt
}

extension DesignColor {
  var color: UIColor {
    switch self {
    case .darkGray:
      return UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
    case .white:
      return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    case .gray:
      return UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1)
    case .lightGray:
      return UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
    case .darkCyan:
      return UIColor(red: 39/255, green: 152/255, blue: 176/255, alpha: 1)
    case .black:
      return UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
    case .whiteDirt:
      return UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    }
  }
}
