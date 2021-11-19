//
//  Extension + UISegmentedControl.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 18/11/21.
//

import Foundation
import UIKit

extension UISegmentedControl {
    
    var endpoint: MovieFeed {
        switch self.selectedSegmentIndex {
        case 0: return .nowPlaying
        case 1: return .popular
        case 2: return .topRated
        case 3: return .upcoming
        case 4: return .trending
        default: fatalError()
        }
    }
}
