//
//  MovieDBClient.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

class MovieDBClient: ApiClient {
  
  let session: URLSession
  static let shared = MovieDBClient()
  
  private convenience init() {
    self.init(configuration: .default)
  }
  
  init(configuration: URLSessionConfiguration) {
    self.session = URLSession(configuration: configuration)
  }
  
  func getData<Element: Decodable>(from: Endpoint, movieRegion: MovieRegion?, movieLanguage: MovieLanguage?, completion: @escaping (Result<Element?, ApiError>) -> Void) {
    
    let endPoint = from
    let query: [URLQueryItem]?
    
    if movieRegion != nil && movieLanguage != nil {
      query = [
        URLQueryItem(name: "language", value: movieLanguage?.language),
        URLQueryItem(name: "region", value: movieRegion?.region)
      ]
    } else {
      query = nil
    }
    
    let urlComponents = endPoint.getUrlComponents(queryItems: query)
    let request = endPoint.request(urlComponents: urlComponents)
    
    fetch(with: request, decode: { json -> Element? in
      
      guard let movieFeedResult = json as? Element else { return  nil }
      return movieFeedResult
      
    }, completion: completion)
  }
  
}
