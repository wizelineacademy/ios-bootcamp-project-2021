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
    return ApiPath.baseUrl.path
  }
  var apiKey: String {
    return ApiPath.apiKey.path
  }
  
  func getUrlComponents(queryItems: [URLQueryItem]?) -> URLComponents {
    var components = URLComponents(string: base)!
    components.path = path
    if var query = queryItems {
      query.insert(URLQueryItem(name: "api_key", value: apiKey), at: 0)
      components.queryItems = query
    } else {
      components.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
    }
    return components
  }
  
  func request(urlComponents: URLComponents) -> URLRequest {
    guard urlComponents.url != nil else {
      fatalError("UrlComponents fail creating the url")
    }
    return URLRequest(url: urlComponents.url!)
  }
  
}
