//
//  EndPoint.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

protocol Endpoint {
    var path: String { get }
}

extension Endpoint {
  
    var base: String {
      return "https://api.themoviedb.org"
    }
    var apiKey: String {
        return "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    }
    
  func getUrlComponents(queryItems:[URLQueryItem]?) -> URLComponents {
    var components = URLComponents(string: base)!
    components.path = path
    if var query = queryItems {
      query.insert(URLQueryItem(name:"api_key", value: apiKey), at: 0)
      components.queryItems = query
    }else{
      components.queryItems = [URLQueryItem(name:"api_key", value: apiKey)]
    }
    return components
  }
    
    func request(urlComponents: URLComponents) -> URLRequest {
        return URLRequest(url: urlComponents.url!)
    }

}
