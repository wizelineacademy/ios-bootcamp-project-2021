//
//  APIBuild.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 28/10/21.
//

import Foundation

struct APIBuild {
    // MARK: - Properties
    var language = "&language="
    var region = "&region="
    var page = "&page="
    
    // MARK: - Life Cycle
    init(language: String = "en", region: String = "US", page: String = "1") {
        self.language += language
        self.region += region
        self.page += page
    }
    
    // MARK: - Helpers
    public func buildURL(api: APIEndPoints, query: String = "Matrix", id: String = "603") -> URL? {
        let safeApi = api.rawValue
        var url: String
        
        switch api {
            
        case .trending, .nowPlaying, .popular, .topRated, .upcoming:
            url = APIConst.baseUrl + safeApi + APIConst.apiKey + self.language + self.region + self.page
            
        case .keyword, .search:
            let query = "&query="+query
            url = APIConst.baseUrl + safeApi + APIConst.apiKey + self.language + query
            
        case .review, .similar, .recommendations:
            let reviewAPI =  safeApi.replacingOccurrences(of: "[id]", with: id)
            url = APIConst.baseUrl + reviewAPI + APIConst.apiKey + self.language
        }
        
        return URL(string: url) ?? nil
    }
    
}
