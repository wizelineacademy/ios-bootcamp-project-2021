//
//  Color+Extensions.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 03/11/21.
//

import Foundation
import UIKit

extension UIColor {
    
    static var trending: UIColor? {
        return UIColor(named: "trending-color")
    }
    
    static var nowPlaying: UIColor? {
        return UIColor(named: "playing-color")
    }
    
    static var popular: UIColor? {
        return UIColor(named: "popular-color")
    }
    
    static var topRated: UIColor? {
        return UIColor(named: "top-rated-color")
    }
    
    static var upcoming: UIColor? {
        return UIColor(named: "upcoming-color")
    }
}
