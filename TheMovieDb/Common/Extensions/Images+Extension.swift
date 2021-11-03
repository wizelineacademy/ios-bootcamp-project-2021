//
//  Images+Extension.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 02/11/21.
//

import Foundation
import UIKit

extension UIImage {
    static var trending: UIImage? {
        return UIImage(named: "trending-topic")
    }
    
    static var nowPlaying: UIImage? {
        return UIImage(named: "play")
    }
    
    static var popular: UIImage? {
        return UIImage(named: "popularity")
    }
    
    static var topRated: UIImage? {
        return UIImage(named: "stars")
    }
    
    static var upcoming: UIImage? {
        return UIImage(named: "online-booking")
    }
    
    static var posterPlaceholder: UIImage? {
        return UIImage(named: "poster-placeholder")
    }
    
    static var warning: UIImage? {
        return UIImage(named: "warning")
    }
}
