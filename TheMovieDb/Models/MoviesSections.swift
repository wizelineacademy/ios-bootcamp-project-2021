//
//  MoviesSections.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 01/12/21.
//

import Foundation

enum MoviesSections: Int, CaseIterable {
    case none
    case popular
    case upcoming
    case playingNow
    case topRated
    case trending
    
    var description: String {
        switch self {
        case .none: return ""
        case .popular: return "Popular"
        case .trending: return "Trending"
        case .playingNow: return "Playing Now"
        case .topRated: return "Top Rated"
        case .upcoming: return "Upcoming"
        }
    }
}
