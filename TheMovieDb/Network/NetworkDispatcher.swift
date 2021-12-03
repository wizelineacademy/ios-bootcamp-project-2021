//
//  Request.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/21/21.
//

import Foundation
import Combine

protocol NetworkDispatcher {
  var session: URLSession { get }
  func dispatch<Element: Decodable>(request: URLRequest) -> AnyPublisher<Element, ApiError>
}

extension NetworkDispatcher {
  
  func dispatch<Element: Decodable>(request: URLRequest) -> AnyPublisher<Element, ApiError> {
    return session
      .dataTaskPublisher(for: request)
      .tryMap { (data, response) in
        guard let httpResponse = response as? HTTPURLResponse else {
          print("response requestFailed")
          throw ApiError.requestFailed
        }
        if httpResponse.statusCode != 200 {
          print("response unsuccesful")
          throw ApiError.responseUnsuccesful
        } else {
          return data
        }
      }
      .decode(type: Element.self, decoder: JSONDecoder())
      .mapError { error in
        print(error.localizedDescription)
        print("response jsonConversionFailure")
        return ApiError.jsonConversionFailure
        
      }
      .eraseToAnyPublisher()
  }
}
