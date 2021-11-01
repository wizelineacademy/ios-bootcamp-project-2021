//
//  APIBuild.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 28/10/21.
//

import Foundation

class APIBuild: APIBuildProtocol {
    // MARK: - Properties
    let parameters: APIParameters
    let api: APIEndPoints
    
    // MARK: - Life Cycle
    init(with parameters: APIParameters, with api: APIEndPoints) {
        self.parameters = parameters
        self.api = api
    }
    
    // MARK: - Helpers
    public func buildURL() -> URL? {
        let safeApi = self.api.rawValue
        var url: String
        
        switch api {
            
        case .trending, .nowPlaying, .popular, .topRated, .upcoming:
            url = APIConst.baseUrl + safeApi + APIConst.apiKey + self.parameters.language + self.parameters.region + self.parameters.page
            
        case .keyword, .search:
            url = APIConst.baseUrl + safeApi + APIConst.apiKey + self.parameters.language + self.parameters.query + self.parameters.page
            
        case .review, .similar, .recommendations:
            let reviewAPI =  safeApi.replacingOccurrences(of: "[id]", with: self.parameters.id)
            url = APIConst.baseUrl + reviewAPI + APIConst.apiKey + self.parameters.language + self.parameters.page
        }
        
        return URL(string: url) ?? nil
    }
    
}
