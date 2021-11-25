//
//  MovieClient.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Combine
import Foundation

class MovieClient: NetworkDispatcher {
  
  let session: URLSession
  static let shared = MovieClient()
  
  private convenience init() {
    self.init(configuration: .default)
  }
  
  private init(configuration: URLSessionConfiguration) {
    self.session = URLSession(configuration: configuration)
  }
  
  private func setUrl(_ from: Endpoint, search: String? = nil) -> URLRequest {
    let endPoint = from
    let query = (search != nil) ? [URLQueryItem(name: "query", value: search)] : nil
    let urlComponents = endPoint.getUrlComponents(queryItems: query)
    let request = endPoint.request(urlComponents: urlComponents)
    return request
  }
  
  func fetch<Element: Decodable>(_ request: Endpoint, kindItem: Element.Type, search: String? = nil) -> AnyPublisher<Element, ApiError> {
    let request = setUrl(request, search: search)
    typealias RequestPublisher = AnyPublisher<Element, ApiError>
    let requestPublisher: RequestPublisher = dispatch(request: request)
    return requestPublisher.eraseToAnyPublisher()
  }
}
