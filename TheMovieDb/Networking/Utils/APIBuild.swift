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
            
        case .TRENDING, .NOW_PLAYING, .POPULAR, .TOP_RATED, .UPCOMING:
            url = APIConst.BASE_URL + safeApi + APIConst.API_KEY + self.language + self.region + self.page
            
        case .KEYWORD, .SEARCH:
            let query = "&query="+query
            url = APIConst.BASE_URL + safeApi + APIConst.API_KEY + self.language + query
            
        case .REVIEWS, .SIMILAR, .RECOMMENDATIONS:
            let reviewAPI =  safeApi.replacingOccurrences(of: "[id]", with: id)
            url = APIConst.BASE_URL + reviewAPI + APIConst.API_KEY + self.language
        }
        
        return URL(string: url) ?? nil
    }
    
}
