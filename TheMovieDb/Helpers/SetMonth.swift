//
//  SetMonth.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/2/21.
//

import Foundation

enum SetMonth: Int {
  case Jan = 1, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec
}

extension SetMonth {
  
  var month: String {
    switch self {
      
    case .Jan: return "Jan"
    case .Feb: return "Feb"
    case .Mar: return "Mar"
    case .Apr: return "Apr"
    case .May: return "May"
    case .Jun: return "Jun"
    case .Jul: return "Jul"
    case .Aug: return "Aug"
    case .Sep: return "Sep"
    case .Oct: return "Oct"
    case .Nov: return "Nov"
    case .Dec: return "Dec"
    }
  }
  
  func setMonth(date: [String]) -> String {
    let suffix = (date[1].prefix(1) != "0") ? 2 : 1
    let monthNumber = String(date[1].suffix(suffix))
    guard let month = SetMonth(rawValue: Int(monthNumber)!) else { return "no month" }
    return "\(month.month) \(date[2]), \(date[0])"
  }
  
}
