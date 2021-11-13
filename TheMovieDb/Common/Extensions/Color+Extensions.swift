//
//  Color+Extensions.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 03/11/21.
//

import Foundation
import UIKit

extension UIColor {
    
    static var trending: UIColor? = UIColor(named: "trending-color")
    
    static var nowPlaying: UIColor? = UIColor(named: "playing-color")
    
    static var popular: UIColor? = UIColor(named: "popular-color")
    
    static var topRated: UIColor? = UIColor(named: "top-rated-color")
    
    static var upcoming: UIColor? = UIColor(named: "upcoming-color")
    
    static var ratingFilled: UIColor? = UIColor(named: "rating-filled")
    
    static var ratingNotFilled: UIColor? = UIColor(named: "rating-filled")?.withAlphaComponent(0.25)
}
