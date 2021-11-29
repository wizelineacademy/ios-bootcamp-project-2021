//
//  Utils.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 14/11/21.
//

import Foundation

struct Utils {
   static func showStar(value: Int) -> String {
        var star: String = ""
        switch value {
        case 0..<2: star = "★☆☆☆☆"
        case 2..<4: star = "★★☆☆☆"
        case 4..<6: star = "★★★☆☆"
        case 6..<8: star = "★★★★☆"
        case 8...10: star = "★★★★★"
        default: star = "TBD"
        }
        return star
    }
}
