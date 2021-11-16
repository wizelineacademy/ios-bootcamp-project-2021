//
//  Utils.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 14/11/21.
//

import Foundation

func showStar(value: Int) -> String {
    var star:String = ""
    if value < 20 && value >= 0 {
        star = "★☆☆☆☆"
    }
    else if value < 40 {
        star = "★★☆☆☆"
    }
    else if value < 50 {
        star = "★★★☆☆"
    }
    else if value < 70 {
        star = "★★★★☆"
    }
    else if value < 90 && value <= 100 {
        star = "★★★★★"
    }
    else {
        star = "TBD"
    }
    return star;
    
}

func fixedDateFormatter(_ date: String?) -> String {
    var fixDate: String = ""
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyy-MM-dd"
    if let originalDate = date {
        if let newDate = dateFormatter.date(from: originalDate) {
            dateFormatter.dateFormat = "dd MMMM yyyy"
            fixDate = dateFormatter.string(from: newDate)
        }
    }
    return fixDate
}

