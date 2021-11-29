//
//  StringExtension.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 28/10/21.
//

import Foundation

extension String {
  func changeToDate() -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd"
    guard let date = dateFormatter.date(from: self) else {
      return Date()
    }
    return date
    
  }
}
