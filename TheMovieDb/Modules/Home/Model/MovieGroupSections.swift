//
//  GroupSections.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import Foundation

enum MovieGroupSections: Int, CaseIterable {
    case popular
    case trending
    case playingNow
    case topRated
    case upcoming
    
    var description: String {
        switch self {
        case .popular: return MoviesSectionConst.popular
        case .trending: return MoviesSectionConst.trending
        case .playingNow: return MoviesSectionConst.playingNow
        case .topRated: return MoviesSectionConst.topRated
        case .upcoming: return MoviesSectionConst.upcoming
        }
    }
    
    var path: APIEndPoints {
        switch self {
        case .popular: return .popular
        case .trending: return .trending
        case .playingNow: return .nowPlaying
        case .topRated: return .topRated
        case .upcoming: return .upcoming
        }
    }
}
