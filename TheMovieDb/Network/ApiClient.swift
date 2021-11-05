//
//  ApiClient.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation
import UIKit

protocol ApiClient {
  var session: URLSession { get }
  func fetch<Element: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> Element?, completion: @escaping (Result<Element, ApiError>) -> Void)
  //  func getData<Element: Decodable>(from: Endpoint, movieRegion: MovieRegion, movieLanguage: MovieLanguage, completion: @escaping (Result<Element?, ApiError>) -> Void)
}

extension ApiClient {
  
  typealias JSONTaskCompletionHandler = (Decodable?, ApiError?) -> Void
  
  private func decodingTask<Element: Decodable>(with request: URLRequest, decodingType: Element.Type, completion: @escaping JSONTaskCompletionHandler ) -> URLSessionDataTask {
    
    let task = session.dataTask(with: request) { ( data, response, _ ) in
      guard let httpResponse = response as? HTTPURLResponse else {
        completion(nil, .requestFailed)
        return
      }
      if httpResponse.statusCode == 200 {
        if let data = data {
          do {
            let item = try JSONDecoder().decode(decodingType, from: data)
            completion(item, nil)
          } catch {
            completion(nil, .jsonConversionFailure)
          }
        } else {
          completion(nil, .invalidData)
        }
      } else {
        completion(nil, .responseUnsuccesful)
      }
    }
    return task
  }
  
  func fetch<Element: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> Element?, completion: @escaping (Result<Element, ApiError>) -> Void) {
    let task = decodingTask(with: request, decodingType: Element.self) {(json, error) in
      DispatchQueue.main.async {
        guard let json = json else {
          if let error = error {
            completion(Result.failure(error))
          } else {
            completion(Result.failure(.invalidData))
          }
          return
        }
        if let value = decode(json) {
          completion(.success(value))
        } else {
          completion(.failure(.jsonParsingFailure))
        }
      }
    }
    task.resume()
  }
  
}
