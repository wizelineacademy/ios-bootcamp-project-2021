//
//  SetMonth.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/2/21.
//

import Foundation

enum SetMonth: Int {
  case Jan = 1, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec
  
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
}
