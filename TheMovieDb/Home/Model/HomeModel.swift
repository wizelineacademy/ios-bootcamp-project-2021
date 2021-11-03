//
//  HomeModel.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 30/10/21.
//

import Foundation
import UIKit

enum HomeSections: CaseIterable {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    var title: String {
        switch self {
        case .trending:
            return "Trending"
        case .nowPlaying:
            return "Now playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top rated"
        case .upcoming:
            return "Upcoming"
        }
    }
    
    var description: String {
        switch self {
        case .trending:
            return "Description of trending section"
        case .nowPlaying:
            return "Description of now playing section"
        case .popular:
            return "Description of popular section"
        case .topRated:
            return "Description of top rated section"
        case .upcoming:
            return "Description of upcoming section"
        }
    }
    
    var color: UIColor? {
        switch self {
        case .trending:
            return UIColor.trending
        case .nowPlaying:
            return UIColor.nowPlaying
        case .popular:
            return UIColor.popular
        case .topRated:
            return UIColor.topRated
        case .upcoming:
            return UIColor.upcoming
        }
    }
    
    var image: UIImage? {
        switch self {
        case .trending:
            return UIImage.trending
        case .nowPlaying:
            return UIImage.nowPlaying
        case .popular:
            return UIImage.popular
        case .topRated:
            return UIImage.topRated
        case .upcoming:
            return UIImage.upcoming
        }
    }
    
    var request: Request & PageableModel {
        switch self {
        case .trending:
            return TrendingRequest()
        case .nowPlaying:
            return NowPlayingRequest()
        case .popular:
            return PopularRequest()
        case .topRated:
            return TopRatedRequest()
        case .upcoming:
            return UpcomingRequest()
        }
    }
}
