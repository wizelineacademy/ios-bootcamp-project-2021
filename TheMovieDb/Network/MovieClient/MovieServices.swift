//
//  MovieServices.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 05/11/21.
//

import Foundation
enum MovieServices {
    case getTrending(page: Int)
    case getNowPlaying(page: Int)
    case getPopular(page: Int)
    case getTopRated(page: Int)
    case getUpcoming(page: Int)
    case serachKeyword(searchText: String)
    case search(searchText: String, page: Int)
    case getReviews(page: Int, id: Int)
    case getSimilars(page: Int, id: Int)
    case getRecommendations(page: Int, id: Int)
}

// MARK: - Endpointavata
extension MovieServices: MovieDBAPIEndpoint {
    
    var base: String {
        return MovieDBNetworkConfig.shared.baseAPIURLString
    }
    
    var path: String {
        switch self {
        case .getTrending:
            return "/3/movie/day"
        case .getNowPlaying:
            return "/3/movie/now_playing"
        case .getPopular:
            return "/3/movie/popular"
        case .getTopRated:
            return "/3/movie/top_rated"
        case .getUpcoming:
            return "/3/movie/upcoming"
        case .serachKeyword:
            return "/3/search/keyword"
        case .search:
            return "/3/search/movie"
        case .getReviews(_, let id):
            return "/3/movie/\(id)/reviews"
        case .getSimilars(_, let id):
            return "/3/movie/\(id)/similar"
        case .getRecommendations(_, let id):
            return "/3/movie/\(id)/recommendations"
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var params: [String: Any]? {
        switch self {
        case .getTrending(let page):
            return ["page": page]
        case .getNowPlaying(let page):
            return ["page": page]
        case .getPopular(let page):
            return ["page": page]
        case .getTopRated(let page):
            return ["page": page]
        case .getUpcoming(let page):
            return ["page": page]
        case .serachKeyword(let searchText):
            return ["query": searchText]
        case .search(let searchText, let page):
            return ["query": searchText, "page": page]
        case .getReviews(let page, _):
            return ["page": page]
        case .getSimilars(let page, _):
            return ["page": page]
        case .getRecommendations(let page, _):
            return ["page": page]
            
        }
    }
    
    var parameterEncoding: ParameterEnconding {
        return .defaultEncoding
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
